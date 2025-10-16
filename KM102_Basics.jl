### A Pluto.jl notebook ###
# v0.20.11

using Markdown
using InteractiveUtils

# ╔═╡ c92b56ba-e4e0-4d23-b7ca-a5950e3a7a9d
using Unitful

# ╔═╡ 6f9043f0-aa70-11f0-17ee-eb038e12f208
md"""
# Kinematik mit Julia
## Geradlinige Bewegung
"""

# ╔═╡ 25be9ae3-0351-4d2a-859e-d9d90bc65e7a
md"""
#### Aufgabenteil (a)
"""

# ╔═╡ 6c9c34bb-c835-497d-b1ca-9f42ac5899e5
begin
	t_ges = 55.0u"minute"
	s_ges = 50.0u"km"
end;

# ╔═╡ e7ce85ac-c915-49eb-b64b-efd27a7cb285
v_avg = s_ges/t_ges |> u"km/hr"

# ╔═╡ 8329289a-5d15-4797-94b7-05aa893f7a10
md"""Die Durchschnittsgeschwindigkeit beträgt $(round(ustrip(u"km/hr",v_avg),digits=1)) km/h.
"""

# ╔═╡ 3bdc74ae-4c15-42e9-8cc4-8baa3606ed7e
md"""
#### Aufgabenteil (b)
"""

# ╔═╡ 4f19b4a2-b2c5-47b8-afb3-f4d76999f5f8
begin
	s1 = 25u"km"
	v1 = 37.5u"km/hr"
	s2 = 25u"km"
	v2 = 100.0u"km/hr"
end;

# ╔═╡ ac188aa6-852f-42d6-ad27-b70ee2daac28
t1 = s1/v1 

# ╔═╡ e5743973-1822-4252-94a6-b5e3527927ef
t2 = s2/v2

# ╔═╡ 7fcfd14a-2e55-4bdd-a421-9757c5366e2c
(s1+s2)/(t1+t2)

# ╔═╡ d3a1fa2b-64af-4465-afb1-66b0e6fab203
md"""Die Durchschnittsgeschwindigkeit beträgt $(round(ustrip(u"km/hr",(s1+s2)/(t1+t2)),digits=1)) km/h. Für den ersten Streckenabschnitt hat das Fahrzeug $(round(ustrip(u"minute",t1),digits=1)) min benötigt.
"""

# ╔═╡ e81e7086-aba5-4868-b0d5-7c92b56e2ed5
md"""
#### Aufgabenteil (c)
"""

# ╔═╡ 14867014-a984-4f8f-9897-423e3b1c652a
begin
	at = 0.6u"m/s^2"
	vs = 110.0u"km/hr"
end;

# ╔═╡ ffed2a3d-fe5e-4342-ad41-b7b50436d6af
md"""Bei konstanter Beschleunigung ``a = \tilde a = \mathrm{const}`` ist die Geschwindigkeit eine lineare Funktion der Zeit,
```math
v(t) = \tilde a t + v_0
```
und der Weg eine quadratische Funktion der Zeit,
```math
s(t) = \frac{1}{2} \tilde a t^2 + v_0 t + s_0\;.
```

Hier gilt ``v_0=0`` (Start aus der Ruhe) und ``s_0=0`` (Wahl der Wegzählung frei gewählt).

Laut Aufgabenstellung ist die Zeit ``t^\star`` gesucht, bei der ``v(t^\star)=v^\star`` ist. Anschließend soll der zurückgelegte Weg ``s(t^\star)`` bestimmt werden.
"""

# ╔═╡ 0cb6daf6-659d-49d0-a8f5-3a6b89ed774e
ts = vs/at |> u"s"

# ╔═╡ 41cbedac-93a3-4fe6-8c48-dbe6fa078f62
s(t) = 0.5*at*t^2;

# ╔═╡ 611369f6-c766-4204-9b50-5d5c6a703c3c
s(ts)

# ╔═╡ 5bbd459e-ba60-4e4d-ac8d-b3069c6c36af
md"""Nach $(round(ustrip(u"s",ts),digits=2)) s beträgt die Geschwindigkeit des Fahrzeugs $(ustrip(u"km/hr",vs)) km/h. In der Zeit hat es den Weg von $(round(ustrip(u"m",s(ts)),digits=1)) m zurückgelegt.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[compat]
Unitful = "~1.23.1"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.5"
manifest_format = "2.0"
project_hash = "ca89e439a5493467f456b6633c507c76f408a0f2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "d2282232f8a4d71f79e85dc4dd45e5b12a6297fb"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.23.1"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    ForwardDiffExt = "ForwardDiff"
    InverseFunctionsUnitfulExt = "InverseFunctions"
    PrintfExt = "Printf"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"
    Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"
"""

# ╔═╡ Cell order:
# ╟─6f9043f0-aa70-11f0-17ee-eb038e12f208
# ╠═c92b56ba-e4e0-4d23-b7ca-a5950e3a7a9d
# ╟─25be9ae3-0351-4d2a-859e-d9d90bc65e7a
# ╠═6c9c34bb-c835-497d-b1ca-9f42ac5899e5
# ╠═e7ce85ac-c915-49eb-b64b-efd27a7cb285
# ╟─8329289a-5d15-4797-94b7-05aa893f7a10
# ╟─3bdc74ae-4c15-42e9-8cc4-8baa3606ed7e
# ╠═4f19b4a2-b2c5-47b8-afb3-f4d76999f5f8
# ╠═ac188aa6-852f-42d6-ad27-b70ee2daac28
# ╠═e5743973-1822-4252-94a6-b5e3527927ef
# ╠═7fcfd14a-2e55-4bdd-a421-9757c5366e2c
# ╟─d3a1fa2b-64af-4465-afb1-66b0e6fab203
# ╟─e81e7086-aba5-4868-b0d5-7c92b56e2ed5
# ╠═14867014-a984-4f8f-9897-423e3b1c652a
# ╟─ffed2a3d-fe5e-4342-ad41-b7b50436d6af
# ╠═0cb6daf6-659d-49d0-a8f5-3a6b89ed774e
# ╠═41cbedac-93a3-4fe6-8c48-dbe6fa078f62
# ╠═611369f6-c766-4204-9b50-5d5c6a703c3c
# ╟─5bbd459e-ba60-4e4d-ac8d-b3069c6c36af
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
