% Returns a 3x3 matrix that represents the jacobian of the end-effector position and orientation
% with respect to the 3 DOFs of the manipulator
function J = jacobian(a0, a1, a2, links)

	J = ones(3,3);
		
	l1 = links(1); l2 = links(2); l3 = links(3);
	c1 = cos(a0); c12 = cos(a0 + a1); c123 = cos(a0 + a1 + a2);
	s1 = sin(a0); s12 = sin(a0 + a1); s123 = sin(a0 + a1 + a2);

	J(1,1) = -l1*s1 - l2*s12 - l3*s123;
	J(1,2) = -l2*s12 - l3*s123;
	J(1,3) = -l3*s123;

	J(2,1) = l1*c1 + l2*c12 + l3*c123;
	J(2,2) = l2*c12 + l3*c123;
	J(2,3) = l3*c123;
end
