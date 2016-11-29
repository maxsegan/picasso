classdef PeelableOrange
    %This class is used to model a perfectly spherical orange to be peeled
    %   Resolution: Resolution of points to model the orange in each axis
    %   Radius: Total radius of the fruit in units
    %   Offset: Offset from the origin of the reference frame
    %   PeelDepth: Depth of the peel, or the "flavedo" in units
    %   AlbedoDepth: Depth of the albedo, the fiberous middle layer in
    %    units
    
    properties (SetAccess = private)
            Resolution
            Radius
            Offset
            PeelDepth
            AlbedoDepth
    end
    
    properties (Access = private)
            Matrix
    end
    
    methods
        function obj = PeelableOrange(resolution, offset, radius, peel_depth, albedo_depth)
            if mod(resolution, 2) == 1
                obj.Resolution = resolution + 1;
            else
                obj.Resolution = resolution;
            end
            obj.Radius = radius;
            obj.Offset = offset;
            obj.PeelDepth = peel_depth;
            obj.AlbedoDepth = albedo_depth;
            obj.Matrix = obj.initializeMatrix();
        end
        
        %We do not want to cut through the fruit, only the outer shells
        function r = maxCutDepth(obj)
           r = obj.PeelDepth + obj.AlbedoDepth;
        end
        
        %We always want to cut the entire peel
        function r = minCutDepth(obj)
            r = obj.PeelDepth;
        end
        
        function plot(obj)
            % TODO take into account obj.Offset
            disp(obj.Matrix);
            %half_res = obj.Resolution / 2;
            for x = 1:obj.Resolution + 1
                %X = (x - 1 - half_res) * obj.Radius / half_res;
                for y = 1:obj.Resolution + 1
                    %Y = (y - 1 - half_res) * obj.Radius  / half_res;
                    for z = 1:obj.Resolution + 1
                        %Z = (z - 1 - half_res) * obj.Radius  / half_res;
                        %Plot a different color based on what it is
                        val = obj.Matrix(x,y,z);
                        if val == 0
                            continue;
                        % For the inside we paint it red
                        elseif val == 1
                            %plot3(X,Y,Z,'MarkerFaceColor',[1 0 0]);
                        % For the peel we paint it orange
                        elseif val == 2
                            %plot3(X,Y,Z,'MarkerFaceColor',[1 .5 0]);
                        % For the albedo we paint it white
                        elseif val == 3
                            %plot3(X,Y,Z,'MarkerFaceColor',[0 0 0]);
                        end
                    end
                end
            end
        end
    end
    
    methods (Access = private)
        %Private helper function to initialize the internal representation
        % of the orange
        %We build an orange as a 3D matrix s.t. the outer portion is
        % represented by 0, the inner portion by 1, the center by -1, and
        % the peel by 2 (albedo represented by 3, not shown)
        % ex) This is the cross section in 2D of the center
        % [ 0 0 2 0 0 ]
        % [ 0 2 1 2 0 ]
        % [ 2 1-1 1 2 ]
        % [ 0 2 1 2 0 ]
        % [ 0 0 2 0 0 ]
        function m = initializeMatrix(obj)
            m = zeros(obj.Resolution + 1, obj.Resolution + 1, obj.Resolution + 1);
            half_res = obj.Resolution / 2;
            %Iterate over all points in the sphere
            for x = 1:obj.Resolution + 1
                X = (x - 1 - half_res) * obj.Radius / half_res;
                for y = 1:obj.Resolution + 1
                    Y = (y - 1 - half_res) * obj.Radius  / half_res;
                    for z = 1:obj.Resolution + 1
                        Z = (z - 1 - half_res) * obj.Radius  / half_res;
                        %Determine if the point is within the sphere, note
                        % it's centered around (0,0,0)
                        if X^2 + Y^2 + Z^2 <= obj.Radius^2
                            m(x,y,z) = 1;
                        end
                    end
                end
            end
            m(half_res + 1,half_res + 1,half_res + 1) = -1;
            %Now we "color" the outer layers - it is easier to first finish
            % filling in the orange for computation and this code only
            % executes once and doesn't change the BigOh of execution
            % since it's another linear pass
            %We deem something "peel" if it's inside the orange and within
            % "peel_depth" of something that is not within the orange
            %The same basic principle applies for the Albedo
            half_peel_depth = ceil(obj.PeelDepth/2. * obj.Resolution);
            half_albedo_depth = half_peel_depth + ceil(obj.AlbedoDepth/2. * obj.Resolution);
            for x = 1:obj.Resolution + 1
                for y = 1:obj.Resolution + 1
                    for z = 1:obj.Resolution + 1
                        if m(x,y,z) == 1
                            %For each point within the orange we explore
                            % every adjacent point within the possible
                            % region of peel
                            for x1 = x-half_peel_depth:x+half_peel_depth
                                if m(x,y,z) == 2
                                    break
                                end
                                for y1 = y-half_peel_depth:y+half_peel_depth
                                    if m(x,y,z) == 2
                                        break;
                                    end
                                    for z1 = z-half_peel_depth:z+half_peel_depth
                                        % TODO check if this is within range
                                        if z1 < 1 || z1 > obj.Resolution + 1 || y1 < 1 || y1 > obj.Resolution + 1 || x1 < 1 || x1 > obj.Resolution + 1
                                            m(x,y,z) = 2;
                                            break;
                                        end
                                        if m(x1,y1,z1) == 0
                                            m(x,y,z) = 2;
                                            break;
                                        end
                                    end
                                end
                            end
                            if m(x,y,z) == 2
                                continue;
                            end
                            %For each point within the orange we explore
                            % every adjacent point within the possible
                            % region of peel
                            for x1 = x-half_albedo_depth:x+half_albedo_depth
                                if m(x,y,z) == 3 || x1 < 1 || x1 > obj.Resolution
                                    m(x,y,z) = 3;
                                    break;
                                end
                                for y1 = y-half_albedo_depth:y+half_albedo_depth
                                    if m(x,y,z) == 3 || y1 < 1 || y1 > obj.Resolution
                                        m(x,y,z) = 3;
                                        break;
                                    end
                                    for z1 = z-half_albedo_depth:z+half_albedo_depth
                                        if z1 < 1 || z1 > obj.Resolution
                                            m(x,y,z) = 3;
                                            break;
                                        end
                                        if m(x1,y1,z1) == 0
                                            m(x,y,z) = 3;
                                            break;
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

