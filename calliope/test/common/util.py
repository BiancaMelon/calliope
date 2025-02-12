import ast
import os
import sys
from pathlib import Path
from typing import Literal, Optional, Union

import pytest
import xarray as xr

import calliope
from calliope import AttrDict

constraint_sets = {
    k: [ast.literal_eval(i) for i in v]
    for k, v in AttrDict.from_yaml(
        os.path.join(os.path.dirname(__file__), "constraint_sets.yaml")
    )
    .as_dict_flat()
    .items()
}

defaults = AttrDict.from_yaml(
    os.path.join(os.path.dirname(calliope.__file__), "config", "defaults.yaml")
)

python36_or_higher = pytest.mark.skipif(
    sys.version_info < (3, 6), reason="Requires ordered dicts from Python >= 3.6"
)


def build_test_model(
    override_dict=None,
    scenario=None,
    model_file="model.yaml",
    timeseries_dataframes=None,
):
    return calliope.Model(
        os.path.join(os.path.dirname(__file__), "test_model", model_file),
        override_dict=override_dict,
        scenario=scenario,
        timeseries_dataframes=timeseries_dataframes,
    )


def check_error_or_warning(error_warning, test_string_or_strings):
    if hasattr(error_warning, "list"):
        output = ",".join(
            str(error_warning.list[i]) for i in range(len(error_warning.list))
        )
    elif hasattr(error_warning, "value"):
        output = str(error_warning.value)
    elif isinstance(error_warning, (list, set)):
        output = ",".join(error_warning)

    if isinstance(test_string_or_strings, list):
        result = all(test_string in output for test_string in test_string_or_strings)
    else:
        result = test_string_or_strings in output

    return result


def check_variable_exists(
    expr_or_constr: Optional[xr.DataArray], variable: str, idx: Optional[dict] = None
):
    """
    Search for existence of a decision variable in a Pyomo constraint.

    Parameters
    ----------
    backend_interface : solver interface library
    constraint : str, name of constraint which could exist in the backend
    variable : str, string to search in the list of variables to check if existing
    """
    if expr_or_constr is None:
        return False

    try:
        var_exists = expr_or_constr.body.astype(str).str.find(variable) > -1
    except (AttributeError, KeyError):
        var_exists = expr_or_constr.astype(str).str.find(variable) > -1

    if idx is not None:
        var_exists = var_exists.loc[idx]

    return var_exists.any()


def build_lp(
    model: calliope.Model,
    outfile: Union[str, Path],
    math: Optional[dict] = None,
    backend: Literal["pyomo"] = "pyomo",
) -> None:
    """
    Write a barebones LP file with which to compare in tests.
    All model parameters and variables will be loaded automatically, as well as a dummy objective if one isn't provided as part of `math`.
    Everything else to be added to the LP file must be defined in `math`.

    Args:
        model (calliope.Model): Calliope model.
        outfile (Union[str, Path]): Path to LP file.
        math (Optional[dict], optional): All constraint/global expression/objective math to apply. Defaults to None.
        backend (Literal["pyomo"], optional): Backend to use to create the LP file. Defaults to "pyomo".
    """
    backend_instance = model._BACKENDS[backend]()
    backend_instance.add_all_parameters(model.inputs, model.run_config)
    for name, dict_ in model.math["variables"].items():
        backend_instance.add_variable(model.inputs, name, dict_)

    if math is not None:
        for component_group, component_math in math.items():
            for name, dict_ in component_math.items():
                getattr(backend_instance, f"add_{component_group.removesuffix('s')}")(
                    model.inputs, name, dict_
                )

    # MUST have an objective for a valid LP file
    if math is None or "objectives" not in math.keys():
        backend_instance.add_objective(
            model.inputs,
            "dummy_obj",
            {"equations": [{"expression": "1 + 1"}], "sense": "minimize"},
        )
    backend_instance._instance.objectives[0].activate()

    backend_instance.verbose_strings()

    backend_instance.to_lp(str(outfile))

    # strip trailing whitespace from `outfile` after the fact,
    # so it can be reliably compared other files in future
    with Path(outfile).open("r") as f:
        stripped_lines = []
        while line := f.readline():
            stripped_lines.append(line.rstrip())

    # reintroduce the trailing newline since both Pyomo and file formatters love them.
    Path(outfile).write_text("\n".join(stripped_lines) + "\n")
