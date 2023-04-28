mutable struct Correlator{SA}
    view_indexes::Matrix{Vector{UnitRange{Int64}}}
    matrix_size::Tuple{Int64,Int64}
    out::Matrix{Float64}
    fg::Matrix{Float64}
    ff::Matrix{Float64}
    gg::Matrix{Float64}

    function Correlator(search_area::Bool=true, search_size::Tuple{Int64,Int64}=(4, 4))
        search_size == (4, 4) || error("The algorithm supports only 4 by 4 regions yet")

        if search_area
            view_indexes = fill([1:1, 1:1], search_size)
            for i in 1:search_size[1]
                for j in 1:search_size[2]
                    view_indexes[i, j] = [i:i+3, j:j+3]
                end
            end


            out = fill(NaN, search_size)
            new{:SA}(view_indexes, search_size, out, out, out, out)
        else
            error("The algorithm without a search area is not supported yet")
        end
    end
end

__single_element_correlate(f, g) = sum(f .* g) / sqrt(sum(f .* f) * sum(g .* g))


function (c::Correlator)(f, g)
    increased_g = zeros(size(g) .+ (3, 3))
    pointer = view(increased_g, 2:5, 2:5)
    pointer .= g
    c.out .= 
        c.view_indexes .|> 
        (x -> __single_element_correlate(f, view(increased_g, x[1], x[2]))) .|> 
        (y -> isnan(y) ? 0.0 : y)
    return c.out
end



# function __get_by_index(matrix::Matrix{T}, i::Int64, j::Int64) where T
#     matrix_size = size(matrix)
#     i in matrix_size[1] && j in matrix_size[2] && return matrix[i, j]
#     return zero(T)
# end
