@testset "test_correlation" begin
    @testset "Test 1" begin
        m1 = [
            1 1 0 0;
            0 0 0 0;
            0 0 0 0;
            1 1 0 0    
        ]
        m2 = [
            0 1 1 0;
            0 0 0 0;
            0 0 0 0;
            0 1 1 0
        ]
        out = [
            0.0 0.0 0.0 0.0;
            0.0 0.5 1.0 0.71;
            0.0 0.0 0.0 0.0;
            0.0 0.0 0.0 0.0
        ]
        c = Correlator()
        @test isapprox(c(m1, m2), out; atol=1e-2)
    end

    @testset "Test 1" begin
        m1 = [
            1 1 0 0;
            0 0 0 0;
            0 0 0 0;
            1 1 0 0    
        ]
        m2 = [
            0 0 1 1;
            0 0 0 0;
            0 0 0 0;
            1 1 0 0
        ]
        out = [
            0.0     0.0     0.0     0.0;
            0.29    0.5     0.58    0.71;
            0.0     0.0     0.0     0.0;
            0.0     0.0     0.0     0.0
        ]
        c = Correlator()
        @test isapprox(c(m1, m2), out; atol=1e-2)
    end
end