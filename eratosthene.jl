

function eratosbarbare(n)
    global nbr = 2; test = true; global cpt = 0;
    while nbr < n
        for nbrinf = 2:(nbr-1)
            if nbr % nbrinf == 0
                #println("$nbr % $nbrinf == 0")
                test = false
                break
            end
        end
        #println("test for $nbr is $test")
        if test == true
            global cpt = cpt + 1
        end
        global nbr = nbr + 1
        test = true
    end
    println("There are $cpt prime numbers between 1 and $n")
end

function fillnbr(c::Channel, n::Int)
    for i = 2:n
        put!(c,i)
    end
end
compteur = 0
function fillprime(cn::Channel, cp::Channel)
    test = true
    for x in cn
        for i = 2:x-1
            if x%i == 0
                test = false
                break
            end
        end
        if test
            put!(cp, x)
            global compteur = compteur + 1
        end
        test = true
    end
end



function eratosmulthread4(n)
    global chn = Channel{Int}(n)
    global chp = Channel{Int}(n)
    @async fillnbr(chn, n)
    for i = 1:4
        @async fillprime(chn, chp)
    end
end
function eratosmulthread8(n)
    global chn = Channel{Int}(n)
    global chp = Channel{Int}(n)
    @async fillnbr(chn, n)
    for i = 1:8
        @async fillprime(chn, chp)
    end
end
function eratosmulthread16(n)
    global chn = Channel{Int}(n)
    global chp = Channel{Int}(n)
    @async fillnbr(chn, n)
    for i = 1:16
        @async fillprime(chn, chp)
    end
end
nbr = 1000000
#println("Eratos Barbare a pris $(@elapsed eratosbarbare(nbr)) secondes")
println("eratosmulthread4 a pris $(@elapsed eratosmulthread4(nbr)) secondes")
println(compteur)
#compteur = 0
#println("eratosmulthread8 a pris $(@elapsed eratosmulthread8(nbr)) secondes")
#println(compteur)
#compteur = 0
#println("eratosmulthread16 a pris $(@elapsed eratosmulthread16(nbr)) secondes")
#println(compteur)
#compteur = 0
