%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @file arm3d.m
% @author Can Erdogan
% @date Jan 21, 2012
% @brief Displays the 3D arm motion given the link lengths, the joint angles trajectory and the 
% time step between each joint angle display. The arm has 3 rotary joints all in the same plane.
% @example arm3d(2,2,1,[0:0.01:1;0:0.02:2;0:0.01:1]',0.1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = arm3d (link1, link2, link3, traj, dt) 

	% Determine the figure size based on the link lengths
	reach = link1 + link2 + link3;
	axis([-reach, reach, -reach, reach]); hold on;
  axis equal; hold on;
    
	% For each entry in the trajectory, determine the joint locations 
	for index = size(traj, 1) : -1 : 1

		[eex, eey, j1x, j1y, j2x, j2y] = forward(traj(index, 1), traj(index, 2), traj(index, 3), link1, link2, link3); 

		% Plot the two lines
		clf;
    plot([0.0;j1x], [0.0;j1y], 'o-', 'linewidth', 3); hold on;
		plot([j1x;j2x], [j1y;j2y], 'go-', 'linewidth', 3); hold on;
    plot([j2x;eex], [j2y;eey], 'co-', 'linewidth', 3); hold on;
    plot([0.0;eex], [0.0;eey], 'ko--', 'linewidth', 2); hold on;
    k = 32; for i = 1 : (k/2-1), plot(reach* [cos(i * pi/k); cos((i+1) * pi/k); ], reach* [sin(i * pi/k); sin((i+1) * pi/k); ], '--r', 'linewidth', 3); hold on; end;
    axis([-reach, reach, -reach, reach]); hold on;
		axis equal; hold on;
    
		% Wait for update
		%pause(dt);
    %pause
	end
end
