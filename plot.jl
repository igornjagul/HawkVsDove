using Plots
#Igor Njagul RA 115-2014
#hawk and dove
# Postoje dve opcije: soko i golub. Ukoliko se dva sokola sretnu u borbi
# za plen, postoji 50% sanse da ce bilo koji od njih da pobedi, ko pobedi
# dobija sve, ko izgubi ne dobija nista, ali placa se cena sukoba.
# Ukoliko se nadju soko i golub, ne dolazi do sukoba, soko odnosi ceo plen
# Ukoliko se nadju dva goluba, dele plen po pola, bez sukoba

# Jednacina sukoba dva sokola je vrednost plena / 2 (50% sanse da pobedi)
# minus cena sukoba /2 (50% sanse da izgubi)

# Pod pretpostavkom da su zavinosti uspesnosti linearne, mozemo formirati
# sistem od dve linearne jednacine koje opisuju uspesnost (fitness) populacija
# u odnosu na udeo jedne od vrsta (u ovom slucaju sokola)

# Analizu vrsimo na osnovu teorije igara.

vrednostPlena = 70

cenaSukoba1 = 30
cenaSukoba2 = 50
cenaSukoba3 = 100

linearizovaniKoeficijentSokola1 = -(vrednostPlena/2) - (cenaSukoba1/2)
linearizovaniKoeficijentSokola2 = -(vrednostPlena/2) - (cenaSukoba2/2)
linearizovaniKoeficijentSokola3 = -(vrednostPlena/2) - (cenaSukoba3/2)

linearizovaniKoeficijentGoluba = -(vrednostPlena/2)

procentualnaZastupljenostSokola = 0:0.02:1

uspesnostSokola1 = (-vrednostPlena/2 - cenaSukoba1/2) .*  procentualnaZastupljenostSokola .+ vrednostPlena
uspesnostSokola2 = (-vrednostPlena/2 - cenaSukoba2/2) .*  procentualnaZastupljenostSokola .+ vrednostPlena
uspesnostSokola3 = (-vrednostPlena/2 - cenaSukoba3/2) .*  procentualnaZastupljenostSokola .+ vrednostPlena
uspesnostGoluba = linearizovaniKoeficijentGoluba .* procentualnaZastupljenostSokola .+ vrednostPlena/2

plot(procentualnaZastupljenostSokola, uspesnostSokola1, title = "Zavisnost uspesnosti od procentualnog udela sokola" ,label = "Uspesnost sokola - prvi slucaj")
plot!(procentualnaZastupljenostSokola, uspesnostSokola2, label = "Uspesnost sokola - drugi slucaj")
plot!(procentualnaZastupljenostSokola, uspesnostSokola3, label = "Uspesnost sokola - treci slucaj")
plot!(procentualnaZastupljenostSokola, uspesnostGoluba, label = "Uspesnost goluba")

savefig("hvd.png")

vreme = 0:1:100

#Analiziracemo treci slucaj

tackaEkvilibrijuma = -vrednostPlena/(2 * (linearizovaniKoeficijentSokola3 - linearizovaniKoeficijentGoluba))

udeoSokola = tackaEkvilibrijuma
udeoGoluba = 1 - tackaEkvilibrijuma

#Proizvoljna vrednost
dostupniResursi = 100000

N0S = floor(1000*udeoSokola)
N0G = floor(1000*udeoGoluba)

maksimalnaPopulacijaGolubova = udeoGoluba * dostupniResursi
maksimalnaPopulacijaSokolova = udeoSokola * dostupniResursi

multiplikator = exp.(-vreme)

Ng = floor.(N0G .* maksimalnaPopulacijaGolubova ./ (N0G .+ (maksimalnaPopulacijaGolubova .- N0G).*multiplikator))
Ns = floor.(N0S .* maksimalnaPopulacijaSokolova ./ (N0S .+ (maksimalnaPopulacijaSokolova .- N0S).*multiplikator))

plot(vreme, Ng, label = "Populacija golubova")
plot!(vreme, Ns, label = "Populacija sokolova")

savefig("populacija.png")
