% Sample initial uncertainty
q0 = [1;2;1];
links = [2,2,1];
NP = 50;
ps0 = repmat(q0', NP, 1) + 0.3*(rand(NP,3) - 0.5);
vis = 1;
if(vis)
	clf
	arm3d(links, q0');
	subplot(1,2,1);
	axis equal
	for i = 1 : NP 
		[eex, eey] = forward(ps0(i,1), ps0(i,2), ps0(i,3), links);
		plot(eex, eey, 'o'); hold on;
	end
end
subplot(1,2,2);
for p_i = 1 : NP
	plot3(ps0(p_i, 1), ps0(p_i, 2), ps0(p_i, 3), 'bo', 'linewidth', 3); hold on;
end
axis([0 pi 0 pi -2 2]);

% For each particle, move towards a wall until you hit it
xdot = [-1 0 0]';
xlim = -2.5;
ps1 = [];
subplot(1,2,1);
grid minor
for p_i = 1 : NP
	q = ps0(p_i,:)';
	[q, eex, eey] = move(links, q, xdot, 250, @(x) (x(1) < xlim));
	ps1(end+1,:) = q;
	plot(eex, eey, 'ro', 'linewidth', 3); hold on;
end
subplot(1,2,2);
for p_i = 1 : NP
	plot3(ps1(p_i, 1), ps1(p_i, 2), ps1(p_i, 3), 'ro', 'linewidth', 3); hold on;
end

% For each particle, move away from the wall a bit
lastPS = ps1;
xs = [-1 0 0; 0.01 0 0; 0 0 -1];
counts = [100; 2; 100];	
cols = {'k', 'c', 'm'};
for ITER = 1 : 3
	ps2 = [];
	idx = mod(ITER,3)+1;
	for p_i = 1 : NP
		q = lastPS(p_i,:)';
		[q, eex, eey] = move(links, q, xs(idx,:)', counts(idx), @(x) (x(1) < xlim));
		ps2(end+1,:) = q;
		subplot(1,2,1);
		plot(eex, eey, [cols{ITER}, 'o'], 'linewidth', 3); hold on;
	end
	subplot(1,2,2);
	for p_i = 1 : NP
		plot3(ps2(p_i, 1), ps2(p_i, 2), ps2(p_i, 3), [cols{ITER}, 'o'], 'linewidth', 3); hold on;
	end
	lastPS = ps2;
end
axis equal
