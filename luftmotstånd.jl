### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ d3e08122-6c94-11eb-18eb-45bee7b3571d
begin
	using Plots
	using PlutoUI
end

# ╔═╡ e4315ede-6c85-11eb-1ec7-cf3210cd87ed
function drag(vx, vy)
	ρ = 1.29
	A = 1.16
	C = 0.7
	m = 1000
	g = 9.8

	Fx = -0.5 * C * A * √(vx^2 + vy^2) * vx
	Fy = - 0.5 * ρ * C * A * √(vx^2 + vy^2) * vy
	
	return (Fx, Fy)
end;

# ╔═╡ 6ecbd440-6c96-11eb-135d-777d94519ad5
function update(x, y, vx, vy, dt)
	m = 1000
	g = 9.8
	
	dragx, dragy = drag(vx, vy)
	vx = vx + dragx/m * dt
	vy = vy + (dragy/m - g)*dt
	
	x = x + vx*dt
	y = y + vy*dt
	
	return (x, y, vx, vy)
end;

# ╔═╡ a9c96a76-6ca7-11eb-0f6e-f1d6043f15ab
function update_nodrag(x, y, vx, vy, dt)
	m = 1000
	g = 9.8
	
	vx = vx
	vy = vy - g*dt
	
	x = x + vx*dt
	y = y + vy*dt
	
	return (x, y, vx, vy)
end;

# ╔═╡ 92d122c2-6c96-11eb-23d6-9d1a2fd0f124
dt = 0.1

# ╔═╡ 29211b7e-6c95-11eb-1684-bd7b3d6302a4
md"t $(@bind t Slider(0:dt:14.3, show_value=true))"

# ╔═╡ 216c5146-6c9f-11eb-276b-bba13dafd96a
begin
	x, y = [0.0], [1000.0]
	xn, yn = 0.0, 1000.0
	vx, vy = 250.0, 0.0
	
	x1, y1 = [0.0], [1000.0]
	xn1, yn1 = 0.0, 1000.0
	vx1, vy1 = 250.0, 0.0
	
	x2, y2 = [0.0], [1000.0]
	xn2, yn2 = 0.0, 1000.0

	for n = dt:dt:t
		xn, yn, vx, vy = update(xn, yn, vx, vy, dt)
		append!(x, xn)
		append!(y, yn)
		
		xn1, yn1, vx1, vy1 = update_nodrag(xn1, yn1, vx1, vy1, dt)
		append!(x1, xn1)
		append!(y1, yn1)
		
		xn2 = xn2 + 250.0*dt
		append!(x2, xn2)
		append!(y2, yn2)
		
	end
	
	scatter(x, y, grid=true, label="drag", markersize=5, markercolor=:blue,
		xlabel="x (m)", ylabel="y (m)", xlims =(0, 4000), ylims=(0, 1050))
	scatter!(x1, y1, label="no drag", markersize=5, markercolor=:red)
	scatter!(x2, y2, label="airplane", markersize=5, markercolor=:green)
end

# ╔═╡ a28988d4-6ca9-11eb-1963-87d6a61d995a
begin
	scatter([0:dt:t], y, grid=true, label="drag", markersize=5, markercolor=:blue,
		xlabel="t (s)", ylabel="höjd (m)", xlims =(0, 15), ylims=(0, 1050))
	scatter!([0:dt:t], y1, label="no drag", markersize=5, markercolor=:red)
end

# ╔═╡ f7c8614e-6ca9-11eb-3437-93ea978f38b6
begin
	scatter([0:dt:t], x, grid=true, label="paket", markersize=5, markercolor=:blue,
		xlabel="t (s)", ylabel="längd (m)", xlims =(0, 15), ylims=(0, 4000))
	scatter!([0:dt:t], x1, label="no drag", markersize=5, markercolor=:red)
end

# ╔═╡ Cell order:
# ╠═d3e08122-6c94-11eb-18eb-45bee7b3571d
# ╠═e4315ede-6c85-11eb-1ec7-cf3210cd87ed
# ╠═6ecbd440-6c96-11eb-135d-777d94519ad5
# ╠═a9c96a76-6ca7-11eb-0f6e-f1d6043f15ab
# ╟─92d122c2-6c96-11eb-23d6-9d1a2fd0f124
# ╠═29211b7e-6c95-11eb-1684-bd7b3d6302a4
# ╟─216c5146-6c9f-11eb-276b-bba13dafd96a
# ╟─a28988d4-6ca9-11eb-1963-87d6a61d995a
# ╟─f7c8614e-6ca9-11eb-3437-93ea978f38b6
