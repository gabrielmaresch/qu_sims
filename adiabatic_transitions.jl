using DifferentialEquations
using Trapz
using WGLMakie
using Bonito
using Observables

Page(exportable=true, offline=true)
WGLMakie.activate!(; use_html_widgets=true)

function energy(n, L; hbar=1, M=1)
    n^2 * hbar^2 * pi^2 / (2 * M * L^2)
end

function phase(ts, es; hbar=1)
    exp(-1im / hbar * trapz(ts, es))
end

function overlap(beta, alpha)
    (alpha == beta) ? -0.5 : 2 * alpha * beta / (alpha^2 - beta^2) * (-1)^(alpha + beta)
end

function f!(da, a, p, t)
    t0, v = p
    dt = 0.01
    ts = t0:dt:t

    Lt = v .* ts
    es12 = [energy(2, Ls) - energy(1, Ls) for Ls in Lt]
    es21 = [energy(1, Ls) - energy(2, Ls) for Ls in Lt]

    da[2] = overlap(2, 1) / t * a[1] * phase(ts, es21)
    da[1] = overlap(1, 2) / t * a[2] * phase(ts, es12)
end

t_start(; L0, v) = (L0 / v, v)

function solve_state(v; L0=1.0, tn=20.0)
    t0 = 1.01 * t_start(L0=L0, v=v)[1]
    prob = ODEProblem(f!, ComplexF64[1.0, 0.0], (t0, tn), t_start(L0=L0, v=v))
    sol = solve(prob, saveat=0.1)

    t_pre = collect(0.0:0.1:t0-0.1)
    t_full = vcat(t_pre, sol.t)
    p1 = vcat(ones(length(t_pre)), abs.(sol[1, :]).^2)
    p2 = vcat(zeros(length(t_pre)), abs.(sol[2, :]).^2)

    return (; t0, t_full, p1, p2)
end

L0 = 1.0
tn = 20.0
v_values = collect(0.05:0.05:2.0)

states = Dict(v => solve_state(v; L0=L0, tn=tn) for v in v_values)

app = App() do session
    v0 = 0.5

    slider = Slider(v_values; value=v0)
    current = Observable(states[v0])

    # Label text is reactive; no Node mutation needed.
    label = DOM.span(lift(v -> "v = $(round(v, digits=2))", slider.value))

    fig = Figure(size=(900, 600))
    ax = Axis(fig[1, 1], xlabel="t", ylabel="Probability")
    lines!(ax, lift(x -> x.t_full, current), lift(x -> x.p1, current), label="P(|1>)")
    lines!(ax, lift(x -> x.t_full, current), lift(x -> x.p2, current), label="P(|2>)")
    vlines!(ax, lift(x -> [x.t0], current), color=:black, linestyle=:dash, label="t0")
    xlims!(ax, 0, tn)
    ylims!(ax, 0, 1)
    axislegend(ax)

    on(slider.value) do v
        current[] = states[v]
    end

    ui = DOM.div(
        DOM.p("v in L0 per s"),
        slider,
        label,
        fig
    )

    Bonito.record_states(session, ui)
end

export_static("adiabatic.html", app)