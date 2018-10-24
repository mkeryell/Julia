N=1000000

function withoutmul()
    compteur = 0
    n = N
    alltests = zeros(Bool, n)
    fill!(alltests, true)
    alltests[1] = false
    limite = 0
    while limite*limite < n
        limite = limite + 1
    end

    for i = 2:limite
        for j = 2*i:i:n
            alltests[j] = false
        end
    end

    for i in alltests
        if i
            compteur = compteur + 1
        end
    end
    println("monothread counter: $compteur")
end

function withmul()
    compteur = Threads.Atomic{Int}(0)
    n = N
    alltests = zeros(Bool, n)
    fill!(alltests, true)
    alltests[1] = false
    limite = 0
    while limite*limite < n
        limite = limite + 1
    end

    Threads.@threads for i = 2:limite
        for j = 2*i:i:n
            alltests[j] = false
        end
    end

    Threads.@threads for i in alltests
        if i
            Threads.atomic_add!(compteur, 1)
        end
    end
    println("multithread counter: $(compteur[])")
end

monotime = @elapsed withoutmul()
multime = @elapsed withmul()

println("monothread: $monotime")
println("multithread: $multime")
