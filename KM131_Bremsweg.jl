### A Pluto.jl notebook ###
# v0.20.11

using Markdown
using InteractiveUtils

# ╔═╡ 58acb76c-7d6c-4670-a70f-4e9c6fad6354
using Unitful,Handcalcs,UnitfulLatexify

# ╔═╡ 4907a7fe-0af1-11f0-1973-cf5e62b0708f
md"""
# Technische Berechnungen mit Julia
## Bremsweg bei konstanter Bremsverögerung"""

# ╔═╡ 29cea616-f348-40f9-ae40-6d3f0b62d9d3
md"""
### Zahlenwerte für beide Fahrzeuge
Wir nutzen das Paket `Unitful`, um mit Einheiten rechnen zu können."""

# ╔═╡ e8fd1aac-5e6e-42e5-a0b1-76a1dab2d61a
begin 
	a1 = -5.0u"m/s^2"  # Bremsverzögerung Fahrzeug 1 (mit Vorzeichen)
	a2 = -3.5u"m/s^2"  # Bremsverzögerung Fahrzeug 2 (mit Vorzeichen)
	v01 = 60.0u"km/hr" # Anfangsgeschwindigkeit Fahrzeug 1
	v02 = v01          # Anfangsgeschwindigkeit Fahrzeug 2
	s01 = 0.0u"m"      # Anfangsweg Fahrzeug 1 (willkürlich zu 0 gesetzt)
	s02 = s01          # Anfangsweg Fahrzeug 2 (willkürlich zu 0 gesetzt)
	tV = 1.0u"s"       # Reaktionszeit (Verzögerungszeit) Fahrzeug 2
end;

# ╔═╡ 40542732-ec01-42ce-b5ec-f151c55fa7f0
md"""
### Vorüberlegung
Bei konstanter Bremsverzögerung ist die Geschwindigkeit eine lineare Funktion der Zeit und der Weg eine quadratische Funktion der Zeit. Das kann man sich entweder merken oder man bestimmt die Stammfunktion der Beschleunigung stets auf's Neue.
In Kürze
```math
a = \tilde{a}=\mathrm{const} \Rightarrow v=\tilde{a}t + v_0\Rightarrow s = \frac{1}{2}\tilde{a} t^2 + v_0 t + s_0
```
mit Integrationskonstanten ``v_0`` und ``s_0``. Man überzeugt sich leicht, dass ``v_0`` und ``s_0`` die Anfangsgeschwindigkeit bzw. der Anfangsweg (zur Zeit 0) sind. 
"""

# ╔═╡ 3fd388f0-a5af-47bc-a2b6-10da614ff905
md"""
### Aufgabenteil (a)
Das Bremsen von Fahrzeug 1 beginnt bei $t=0$.
Im Code wird die Beschleunigung während des Bremsvorgangs `a1` bzw. `a2` genannt (für Fahrzeug 1 bzw. 2).
"""

# ╔═╡ 789c61d8-a6f9-4be3-ba68-0f413e7ebd4b
s1(t) = 0.5*a1*t^2 + v01*t + s01;

# ╔═╡ 9fd34d43-de2f-4b1a-bc46-4456198c7c2f
md"""Der Bremsweg und die Bremsdauer sind dadurch charakterisiert, dass am Ende des Bremsvorgangs die Geschwindigkeit Null ist. Da die zu lösenden Gleichungen alle sehr einfach sind, kann man hier analytisch rechnen. Ein numerisches Lösen ist nicht notwendig.
```math
v(t_\mathrm{B}) = 0 \Leftrightarrow t_\mathrm{B} = -\frac{v_0}{\tilde{a}}
```
Der Bremsweg ergibt sich durch Einsetzen der Bremszeit ``t_\mathrm{S}`` in die Formel für den Weg.
"""

# ╔═╡ 479114ee-7cb2-4648-bcfa-85854d17e034
md"""Für Fahrzeug 1 ergibt sich folgende Rechnung."""

# ╔═╡ 675fb7ef-79de-4730-8a45-ae9b8bafc8de
@handcalcs begin
	a1
	v01
	tB1 = -v01/a1 |> u"s"
	sB1 = s1(tB1) |> u"m"
end

# ╔═╡ fa340736-3315-4869-aab5-7ade0ded9621
md"""Beachten Sie: Die oben stehende Codezelle könnte man ausblenden, weil alle relevanten Informationen in der Ausgabe der Codezelle enthalten sind. Die Zelle ist hier eingeblendet, damit für Lernende der Syntax des `handcalcs`-Macro erkennbar ist."""

# ╔═╡ ddee9e7d-7bdb-409c-b166-a0618e981a93
md"""
### Aufgabenteil (b)
Das zweite Fahrzeug beginnt später zu bremsen und bremst mit geringerer Bremsverzögerung. Zur Bremszeit und zum Bremsweg kommt jeweils der Teil dazu, bei dem das Fahrzeug zu Beginn mit konstanter Geschwindigkeit weiterfährt (``t<t_\mathrm{V}``). 

Wenn wir die Zeitzählung beginnen, wenn Fahrzeug 1 zu bremsen beginnt, gilt für den Weg von Fahrzeug 2 für $t\ge t_\mathrm{V}$ die Formel
```math
s_2 = \frac{1}{2}\tilde{a}_2 (t-t_\mathrm{V})^2 + v_{02} t + s_{02}\;.
```
"""

# ╔═╡ 37b24277-f4bf-40f0-837a-6f8c836e1a56
s2(t) = 0.5*a2*(t-tV)^2 + v02*t + s02;

# ╔═╡ 7aed3d51-45bd-4d10-bf66-13c757d7d8a6
md"""Einsetzen der Zahlenwerte ergibt Bremsdauer und Bremsweg für Fahrzeug 2 (beides gemessen ab dem Bremsbeginn von Fahrzeug 1)."""

# ╔═╡ 71ef5351-aead-4240-ab1a-de7b2612e39f
@handcalcs begin
	a2
	v02
	tB2 = -v02/a2 + tV |> u"s"
	sB2 = s2(tB2)  |> u"m"
end

# ╔═╡ 52c5e59b-876b-4259-8db5-ee6a6ed5bb58
md"""
### Aufgabenteil (c)
Ein Auffahrunfall wird vermieden, wenn der Abstand zwischen den Fahrzeugen zu Beginn (``t=0``) mindestens der Differenz der Bremswege entspricht."""

# ╔═╡ 5b917c09-25dc-403e-aff9-341a43c2f0cb
@handcalcs begin
	sB1
	sB2
	Lmin = sB2 - sB1
end

# ╔═╡ 223cb619-fc01-408a-9ee5-a343e5014aa9
md"""Die Fahrzeuge müssen zu Beginn mindestens den Abstand von $(ceil(ustrip(u"m",Lmin),digits=1)) Meter haben, damit es nicht zum Auffahren kommt."""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Handcalcs = "e8a07092-c156-4455-ab8e-ed8bc81edefb"
Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"
UnitfulLatexify = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"

[compat]
Handcalcs = "~0.5.0"
Unitful = "~1.22.0"
UnitfulLatexify = "~1.6.4"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.5"
manifest_format = "2.0"
project_hash = "9f5af05a6dac2d56e7424667bdace0835eeb91ca"

[[deps.AbstractTrees]]
git-tree-sha1 = "2d9c9a55f9c93e8887ad391fbae72f8ef55e1177"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.4.5"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "7eee164f122511d3e4e1ebadb7956939ea7e1c77"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.3.6"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.Handcalcs]]
deps = ["AbstractTrees", "CodeTracking", "InteractiveUtils", "LaTeXStrings", "Latexify", "MacroTools", "PrecompileTools", "Revise", "TestHandcalcFunctions"]
git-tree-sha1 = "1bb18c94645287fa0c499da38a6f04f74ef8f66d"
uuid = "e8a07092-c156-4455-ab8e-ed8bc81edefb"
version = "0.5.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "4bf4b400a8234cff0f177da4a160a90296159ce9"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.9.41"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.Latexify]]
deps = ["Format", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "cd714447457c660382fe634710fb56eb255ee42e"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.6"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.LoweredCodeUtils]]
deps = ["JuliaInterpreter"]
git-tree-sha1 = "688d6d9e098109051ae33d126fcfc88c4ce4a021"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "3.1.0"

[[deps.MacroTools]]
git-tree-sha1 = "72aebe0b5051e5143a079a4685a46da330a40472"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.15"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OrderedCollections]]
git-tree-sha1 = "cc4054e898b852042d7b503313f7ad03de99c3dd"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.0"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.Revise]]
deps = ["CodeTracking", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "REPL", "Requires", "UUIDs", "Unicode"]
git-tree-sha1 = "9bb80533cb9769933954ea4ffbecb3025a783198"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.7.2"

    [deps.Revise.extensions]
    DistributedExt = "Distributed"

    [deps.Revise.weakdeps]
    Distributed = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TestHandcalcFunctions]]
git-tree-sha1 = "54dac4d0a0cd2fc20ceb72e0635ee3c74b24b840"
uuid = "6ba57fb7-81df-4b24-8e8e-a3885b6fcae7"
version = "0.2.4"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "c0667a8e676c53d390a09dc6870b3d8d6650e2bf"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.22.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "975c354fcd5f7e1ddcc1f1a23e6e091d99e99bc8"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.4"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"
"""

# ╔═╡ Cell order:
# ╟─4907a7fe-0af1-11f0-1973-cf5e62b0708f
# ╠═58acb76c-7d6c-4670-a70f-4e9c6fad6354
# ╟─29cea616-f348-40f9-ae40-6d3f0b62d9d3
# ╠═e8fd1aac-5e6e-42e5-a0b1-76a1dab2d61a
# ╟─40542732-ec01-42ce-b5ec-f151c55fa7f0
# ╟─3fd388f0-a5af-47bc-a2b6-10da614ff905
# ╠═789c61d8-a6f9-4be3-ba68-0f413e7ebd4b
# ╟─9fd34d43-de2f-4b1a-bc46-4456198c7c2f
# ╟─479114ee-7cb2-4648-bcfa-85854d17e034
# ╠═675fb7ef-79de-4730-8a45-ae9b8bafc8de
# ╟─fa340736-3315-4869-aab5-7ade0ded9621
# ╟─ddee9e7d-7bdb-409c-b166-a0618e981a93
# ╠═37b24277-f4bf-40f0-837a-6f8c836e1a56
# ╟─7aed3d51-45bd-4d10-bf66-13c757d7d8a6
# ╟─71ef5351-aead-4240-ab1a-de7b2612e39f
# ╟─52c5e59b-876b-4259-8db5-ee6a6ed5bb58
# ╟─5b917c09-25dc-403e-aff9-341a43c2f0cb
# ╟─223cb619-fc01-408a-9ee5-a343e5014aa9
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
