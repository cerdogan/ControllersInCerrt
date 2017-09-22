function [q, eex, eey] = move(links, q, xdot, MAX_ITERS, test, vis)

	if(nargin < 6), vis = 0; end;
	delta = 0.02;
	if(vis), clf, end;
	ql = q;
	for iter = 1 : MAX_ITERS

		% Update the joint values
		J = jacobian(q(1), q(2), q(3), links);
		J = J + eye(3) * 1e-5;
		Jinv = inv(J);
		qdot = Jinv * xdot;
		qdot = qdot / norm(qdot) * delta;
		qdot = qdot + 1e-2 * (rand(3,1) - 0.5);
		q = q + qdot;

		% Check if reached the wall
		[eex, eey, th] = forward(q(1), q(2), q(3), links);
		if(test([eex, eey, th]))
			q = ql;
			break; 
		end;
		ql = q;

		if(vis)
			arm3d(links, q');
			sleep(0.01);
			grid minor
		end
	end
	if(vis), '1', pause; end;
end
