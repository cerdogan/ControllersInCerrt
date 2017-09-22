function [eex, eey, th, j1x, j1y, j2x, j2y] = forward(a0, a1, a2, links)

	% Compute the joint1 location
	j1x = cos(a0) * links(1);
	j1y = sin(a0) * links(1);

	% Compute the joint2 location
	j2x = j1x + cos(a0 + a1) * links(2);
	j2y = j1y + sin(a0 + a1) * links(2);

	% Compute the end-effector location
	eex = j2x + cos(sum(a0 + a1 + a2)) * links(3);
	eey = j2y + sin(sum(a0 + a1 + a2)) * links(3);
	th = sum(a0 + a1 + a2);
end
