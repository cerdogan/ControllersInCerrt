function [eex, eey, j1x, j1y, j2x, j2y] = forward(a0, a1, a2)

	% Compute the joint1 location
	j1x = cos(a0) * link1;
	j1y = sin(a0) * link1;

	% Compute the joint2 location
	j2x = j1x + cos(a0 + a1) * link2;
	j2y = j1y + sin(a0 + a1) * link2;

	% Compute the end-effector location
	eex = j2x + cos(sum(a0 + a1 + a2)) * link3;
	eey = j2y + sin(sum(a0 + a1 + a2)) * link3;
end
