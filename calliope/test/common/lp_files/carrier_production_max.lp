\* Source Pyomo model name=None *\

min
objectives(0):
+2 ONE_VAR_CONSTANT

s.t.

c_u_constraints(carrier_production_max)(0)_:
+1 variables(carrier_prod)(a__test_supply_elec__electricity__2005_01_01_00_00)
-1 variables(energy_cap)(a__test_supply_elec)
<= 0

c_u_constraints(carrier_production_max)(1)_:
+1 variables(carrier_prod)(a__test_supply_elec__electricity__2005_01_01_01_00)
-1 variables(energy_cap)(a__test_supply_elec)
<= 0

c_u_constraints(carrier_production_max)(2)_:
+1 variables(carrier_prod)(a__test_transmission_elec_b__electricity__2005_01_01_00_00)
-1 variables(energy_cap)(a__test_transmission_elec_b)
<= 0

c_u_constraints(carrier_production_max)(3)_:
+1 variables(carrier_prod)(a__test_transmission_elec_b__electricity__2005_01_01_01_00)
-1 variables(energy_cap)(a__test_transmission_elec_b)
<= 0

c_u_constraints(carrier_production_max)(4)_:
+1 variables(carrier_prod)(a__test_transmission_heat_b__heat__2005_01_01_00_00)
-1 variables(energy_cap)(a__test_transmission_heat_b)
<= 0

c_u_constraints(carrier_production_max)(5)_:
+1 variables(carrier_prod)(a__test_transmission_heat_b__heat__2005_01_01_01_00)
-1 variables(energy_cap)(a__test_transmission_heat_b)
<= 0

c_u_constraints(carrier_production_max)(6)_:
+1 variables(carrier_prod)(b__test_supply_elec__electricity__2005_01_01_00_00)
-1 variables(energy_cap)(b__test_supply_elec)
<= 0

c_u_constraints(carrier_production_max)(7)_:
+1 variables(carrier_prod)(b__test_supply_elec__electricity__2005_01_01_01_00)
-1 variables(energy_cap)(b__test_supply_elec)
<= 0

c_u_constraints(carrier_production_max)(8)_:
+1 variables(carrier_prod)(b__test_transmission_elec_a__electricity__2005_01_01_00_00)
-1 variables(energy_cap)(b__test_transmission_elec_a)
<= 0

c_u_constraints(carrier_production_max)(9)_:
+1 variables(carrier_prod)(b__test_transmission_elec_a__electricity__2005_01_01_01_00)
-1 variables(energy_cap)(b__test_transmission_elec_a)
<= 0

c_u_constraints(carrier_production_max)(10)_:
+1 variables(carrier_prod)(b__test_transmission_heat_a__heat__2005_01_01_00_00)
-1 variables(energy_cap)(b__test_transmission_heat_a)
<= 0

c_u_constraints(carrier_production_max)(11)_:
+1 variables(carrier_prod)(b__test_transmission_heat_a__heat__2005_01_01_01_00)
-1 variables(energy_cap)(b__test_transmission_heat_a)
<= 0

c_e_ONE_VAR_CONSTANT:
ONE_VAR_CONSTANT = 1.0

bounds
   100 <= variables(energy_cap)(a__test_supply_elec) <= 100
   0 <= variables(energy_cap)(a__test_transmission_elec_b) <= 10
   0 <= variables(energy_cap)(a__test_transmission_heat_b) <= 5
   0 <= variables(energy_cap)(b__test_supply_elec) <= 10
   0 <= variables(energy_cap)(b__test_transmission_elec_a) <= 10
   0 <= variables(energy_cap)(b__test_transmission_heat_a) <= 5
   0 <= variables(carrier_prod)(a__test_supply_elec__electricity__2005_01_01_00_00) <= +inf
   0 <= variables(carrier_prod)(a__test_supply_elec__electricity__2005_01_01_01_00) <= +inf
   0 <= variables(carrier_prod)(b__test_supply_elec__electricity__2005_01_01_00_00) <= +inf
   0 <= variables(carrier_prod)(b__test_supply_elec__electricity__2005_01_01_01_00) <= +inf
   0 <= variables(carrier_prod)(b__test_transmission_elec_a__electricity__2005_01_01_00_00) <= +inf
   0 <= variables(carrier_prod)(b__test_transmission_elec_a__electricity__2005_01_01_01_00) <= +inf
   0 <= variables(carrier_prod)(a__test_transmission_elec_b__electricity__2005_01_01_00_00) <= +inf
   0 <= variables(carrier_prod)(a__test_transmission_elec_b__electricity__2005_01_01_01_00) <= +inf
   0 <= variables(carrier_prod)(b__test_transmission_heat_a__heat__2005_01_01_00_00) <= +inf
   0 <= variables(carrier_prod)(b__test_transmission_heat_a__heat__2005_01_01_01_00) <= +inf
   0 <= variables(carrier_prod)(a__test_transmission_heat_b__heat__2005_01_01_00_00) <= +inf
   0 <= variables(carrier_prod)(a__test_transmission_heat_b__heat__2005_01_01_01_00) <= +inf
end
