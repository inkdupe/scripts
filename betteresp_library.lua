if getgenv().Executed then return;else getgenv().Executed=true;end local v0=game:GetService("Players");local v1=game:GetService("UserInputService");local v2=game:GetService("RunService");local v3=v0.LocalPlayer;local v4=v3:GetMouse();local v5=workspace.CurrentCamera;local v6=true;local function v7(v15) local v16=v15.Character or v15.CharacterAdded:Wait() ;local v17=v16:WaitForChild("Humanoid");local v18=v16:WaitForChild("HumanoidRootPart");return v16,v17,v18;end local function v8(v19) while  not v19:FindFirstChild("HumanoidRootPart") do wait();end local v20=v19.HumanoidRootPart;local v21=Drawing.new("Line");v21.Visible=false;v21.Color=getgenv().ESPSettings.Tracer.Color;v21.Thickness=1;v21.Transparency=1 -getgenv().ESPSettings.Tracer.Transparency ;v2.RenderStepped:Connect(function() if (v19 and v20 and v6) then local v111,v112=v5:worldToViewportPoint(v20.Position);if v112 then v21.Visible=v6 and getgenv().ESPSettings.Tracer.Enabled ;if (getgenv().ESPSettings.Tracer.Position=="Top") then v21.From=Vector2.new(v5.ViewportSize.X/2 ,0);elseif (getgenv().ESPSettings.Tracer.Position=="Middle") then v21.From=Vector2.new(v5.ViewportSize.X/2 ,v5.ViewportSize.Y/2 );elseif (getgenv().ESPSettings.Tracer.Position=="Bottom") then v21.From=Vector2.new(v5.ViewportSize.X/2 ,v5.ViewportSize.Y);elseif (getgenv().ESPSettings.Tracer.Position=="Cursor") then v21.From=Vector2.new(v1:GetMouseLocation().X,v1:GetMouseLocation().Y);else warn("Invalid setting for tracer position");return;end v21.To=Vector2.new(v111.X,v111.Y);v21.Color=getgenv().ESPSettings.Tracer.Color;v21.Transparency=1 -getgenv().ESPSettings.Tracer.Transparency ;else v21.Visible=false;end else v21.Visible=false;end end);v19.AncestryChanged:Connect(function(v95,v96) if  not v96 then v20=nil;end end);end local function v9(v27) while  not v27:FindFirstChild("Humanoid") do wait();end local v28=v27.Humanoid;local v29={};local function v30(v97) if v29[v97] then v29[v97]:Destroy();v29[v97]=nil;end end local function v31(v98) if (v28 and (v28.RigType==Enum.HumanoidRigType.R6) and (v98.Name~="HumanoidRootPart")) then local v115=Drawing.new("Line");v115.Visible=false;v115.Color=getgenv().ESPSettings.Skeleton.Color;v115.Thickness=1;v115.Transparency=1;v29[v98.Name]=v115;game:GetService("RunService").RenderStepped:Connect(function() if (v98 and v98.Parent and v6 and getgenv().ESPSettings.Skeleton.Enabled) then local v187,v188=v5:WorldToViewportPoint(v98.Position);local v189=v5:WorldToViewportPoint(v98.Position-(v98.CFrame.UpVector * (v98.Size.Y/3)) );local v190=v5:WorldToViewportPoint(v98.Position + (v98.CFrame.UpVector * (v98.Size.Y/3)) );if (v188 and (v187.Z>0)) then v115.Visible=true;v115.Color=getgenv().ESPSettings.Skeleton.Color;v115.From=Vector2.new(v189.X,v189.Y);v115.To=Vector2.new(v190.X,v190.Y);else v115.Visible=false;end else v115.Visible=false;end end);elseif (v28 and (v28.RigType==Enum.HumanoidRigType.R15) and (v98.Name~="LeftHand") and (v98.Name~="RightHand") and (v98.Name~="LeftFoot") and (v98.Name~="RightFoot") and (v98.Name~="HumanoidRootPart")) then local v154=Drawing.new("Line");v154.Visible=false;v154.Color=getgenv().ESPSettings.Skeleton.Color;v154.Thickness=1;v154.Transparency=1;v29[v98.Name]=v154;game:GetService("RunService").RenderStepped:Connect(function() if (v98 and v98.Parent and v6 and getgenv().ESPSettings.Skeleton.Enabled) then local v220,v221=v5:WorldToViewportPoint(v98.Position);local v222=v5:WorldToViewportPoint(v98.Position-(v98.CFrame.UpVector * (v98.Size.Y/4)) );local v223=v5:WorldToViewportPoint(v98.Position + (v98.CFrame.UpVector * (v98.Size.Y/4)) );if (v221 and (v220.Z>0)) then v154.Visible=true;v154.Color=getgenv().ESPSettings.Skeleton.Color;if ((v98.Name=="LowerTorso") and v29['UpperTorso']) then v154.From=Vector2.new(v222.X,v222.Y);v154.To=v29['UpperTorso'].From;elseif ((v98.Name=="LeftLowerLeg") and v29['LeftUpperLeg']) then v154.From=Vector2.new(v222.X,v222.Y);v154.To=v29['LeftUpperLeg'].From;elseif ((v98.Name=="RightLowerLeg") and v29['RightUpperLeg']) then v154.From=Vector2.new(v222.X,v222.Y);v154.To=v29['RightUpperLeg'].From;elseif ((v98.Name=="LeftUpperArm") and v29['LeftLowerArm']) then v154.From=v29['LeftLowerArm'].To;v154.To=Vector2.new(v223.X,v223.Y);elseif ((v98.Name=="RightUpperArm") and v29['RightLowerArm']) then v154.From=v29['RightLowerArm'].To;v154.To=Vector2.new(v223.X,v223.Y);else v154.From=Vector2.new(v222.X,v222.Y);v154.To=Vector2.new(v223.X,v223.Y);end else v154.Visible=false;end else v154.Visible=false;end end);end end for v99,v100 in v27:GetChildren() do if v100:IsA("BasePart") then v31(v100);v27.ChildRemoved:Connect(function(v142) if (v142==v100) then v30(v142.Name);end end);v100.AncestryChanged:Connect(function(v143,v144) if  not v144 then v30(v100.Name);end end);end end for v101,v102 in pairs(v29) do local v103=Drawing.new("Line");v103.Visible=false;v103.Color=getgenv().ESPSettings.Skeleton.Color;v103.Thickness=1;v103.Transparency=1;game:GetService("RunService").RenderStepped:Connect(function() if (v103 and (v103~=nil) and v6 and getgenv().ESPSettings.Skeleton.Enabled) then v103.Color=getgenv().ESPSettings.Skeleton.Color;if (v101=="Torso") then if (v29['Head'] and (v29['Head']~=nil)) then v103.From=v29['Head'].From;v103.Visible=v29['Head'].Visible;else v103:Destroy();Conenction=nil;end v103.To=v102.To;elseif ((v101=="Left Arm") or (v101=="Right Arm")) then if (v29['Torso'] and (v29['Torso']~=nil)) then v103.From=v29['Torso'].To;v103.Visible=v29['Torso'].Visible;else v103:Destroy();Conenction=nil;end v103.To=v102.To;elseif ((v101=="Left Leg") or (v101=="Right Leg")) then if (v29['Torso'] and (v29['Torso']~=nil)) then v103.From=v29['Torso'].From;v103.Visible=v29['Torso'].Visible;else v103:Destroy();Conenction=nil;end v103.To=v102.To;elseif ((v101=="LeftUpperLeg") or (v101=="RightUpperLeg")) then v103.From=v102.To;if (v29['LowerTorso'] and (v29['LowerTorso']~=nil)) then v103.To=v29['LowerTorso'].From;v103.Visible=v29['LowerTorso'].Visible;else v103:Destroy();Conenction=nil;end elseif (v101=="Head") then v103.From=v102.From;if (v28 and (v28.RigType==Enum.HumanoidRigType.R15)) then if (v29['UpperTorso'] and (v29['UpperTorso']~=nil)) then v103.To=v29['UpperTorso'].To;v103.Visible=v29['UpperTorso'].Visible;else v103:Destroy();Conenction=nil;end elseif (v28 and (v28.RigType==Enum.HumanoidRigType.R6)) then if (v29['Torso'] and (v29['Torso']~=nil)) then v103.To=v29['Torso'].To;v103.Visible=v29['Torso'].Visible;else v103:Destroy();Conenction=nil;end end elseif ((v101=="LeftUpperArm") or (v101=="RightUpperArm")) then v103.From=v102.To;if (v29['UpperTorso'] and (v29['UpperTorso']~=nil)) then v103.To=v29['UpperTorso'].To;v103.Visible=v29['UpperTorso'].Visible;else v103:Destroy();Conenction=nil;end else v103:Destroy();Conenction=nil;end else v103.Visible=false;end end);end end local function v10(v32) local v33=Instance.new("Highlight",v32);v2.RenderStepped:Connect(function() if (v32 and v6 and getgenv().ESPSettings.Highlight.Enabled) then v33.Enabled=true;v33.FillColor=getgenv().ESPSettings.Highlight.FillColor;v33.FillTransparency=getgenv().ESPSettings.Highlight.FillTransparency;v33.OutlineColor=getgenv().ESPSettings.Highlight.OutlineColor;v33.OutlineTransparency=getgenv().ESPSettings.Highlight.OutlineTransparency;else v33.Enabled=false;end end);end local function v11(v34) while  not v34:FindFirstChild("HumanoidRootPart") do wait();end local v35=v34.HumanoidRootPart;local v36=Drawing.new("Square");v36.Thickness=1;v36.Filled=true;v36.Color=getgenv().ESPSettings.Box.FillColor;v36.Visible=false;v36.ZIndex=1;local v43=Drawing.new("Square");v43.Thickness=getgenv().ESPSettings.Box.Thickness;v43.Filled=false;v43.Color=getgenv().ESPSettings.Box.OutlineColor;v43.Visible=false;v43.ZIndex=2;v2.RenderStepped:Connect(function() if (v35 and v34) then local v132,v133=v5:worldToViewportPoint(v35.Position);local v134=(1/(v132.Z * math.tan(math.rad(v5.FieldOfView * 0.5 )) * 2)) * 100 ;local v135,v136=math.floor(40 * v134 ),math.floor(60 * v134 );if (v133 and v6 and getgenv().ESPSettings.Box.Enabled) then v36.Visible=true;v43.Visible=true;local v163=Vector2.new(v132.X-(v36.Size.X/2) ,v132.Y-(v36.Size.Y/2) );local v164=Vector2.new(v135,v136);v43.Size=v164;v43.Position=v163;v36.Size=v164;v36.Position=v163;v43.Color=getgenv().ESPSettings.Box.OutlineColor;v43.Thickness=getgenv().ESPSettings.Box.Thickness;v36.Color=getgenv().ESPSettings.Box.FillColor;v36.Transparency=1 -getgenv().ESPSettings.Box.FillTransparency ;v43.Transparency=1 -getgenv().ESPSettings.Box.OutlineTransparency ;else v36.Visible=false;v43.Visible=false;end else v36.Visible=false;v43.Visible=false;end end);v34.AncestryChanged:Connect(function(v109,v110) if  not v110 then v35=nil;end end);end local function v12(v51) while  not v51:FindFirstChild("HumanoidRootPart") or  not v51:WaitForChild("Humanoid") or  not v51:WaitForChild("Head")  do wait();end local v52=v51.HumanoidRootPart;local v53=v51.Humanoid;local v54=v51.Head;if ( not v53 or  not v54) then return;end local v55={DisplayDistanceType=nil,NameDisplayDistance=nil,NameOcclusion=nil,HealthDisplayDistance=nil,HealthDisplayType=nil};v55['DisplayDistanceType']=v53.DisplayDistanceType;v55['NameDisplayDistance']=v53.NameDisplayDistance;v55['NameOcclusion']=v53.NameOcclusion;v55['HealthDisplayDistance']=v53.HealthDisplayDistance;v55['HealthDisplayType']=v53.HealthDisplayType;local v66=Instance.new("Model",v51);local v67=Instance.new("Part",v66);local v68=v53:Clone();local v69=Instance.new("Weld",v67);v69.C0=CFrame.new(0,0.5,0);v69.Part0=v54;v69.Part1=v67;v67.Name="Head";v67.CanCollide=false;v67.Size=Vector3.new(0.01,0.01,0.01);v67.Transparency=0.99;v67.Anchored=false;v68.Parent=v66;v68.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.Subject;v68.NameDisplayDistance=math.huge;v68.NameOcclusion=Enum.NameOcclusion.OccludeAll;v68.HealthDisplayType=Enum.HumanoidHealthDisplayType.AlwaysOff;v68.DisplayName="0.0";v2.RenderStepped:Connect(function() if (v51 and v52) then local v139=v51:FindFirstChild("Humanoid");if  not v139 then return;end local v140,v140,v141=v7(v3);if (getgenv().ESPSettings.Name.Enabled and v6) then if getgenv().ESPSettings.Name.ShowName then v139.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.Subject;v139.NameDisplayDistance=math.huge;v139.NameOcclusion=Enum.NameOcclusion.OccludeAll;else v139.NameDisplayDistance=v55['NameDisplayDistance'];v139.NameOcclusion=v55['NameOcclusion'];end if getgenv().ESPSettings.Name.ShowHealth then v139.HealthDisplayDistance=math.huge;v139.HealthDisplayType=Enum.HumanoidHealthDisplayType.AlwaysOn;else v139.HealthDisplayDistance=v55['HealthDisplayDistance'];v139.HealthDisplayType=v55['HealthDisplayType'];end if (v67 and v68 and v69 and v52 and v141) then if getgenv().ESPSettings.Name.ShowDistance then v67.Transparency=0.99;local v233=math.floor(((v52.Position-v141.Position).magnitude * 10) + 0.5 )/10 ;v68.DisplayName=v233;v69.C0=CFrame.new(0,0.5 + (math.floor(v233)/100) ,0);else v67.Transparency=1;end end else v139.NameDisplayDistance=v55['NameDisplayDistance'];v139.NameOcclusion=v55['NameOcclusion'];v139.HealthDisplayDistance=v55['HealthDisplayDistance'];v139.HealthDisplayType=v55['HealthDisplayType'];if v67 then v67.Transparency=1;end end end end);end local function v13(v88) print("Adding ESP to:",v88);v8(v88);v9(v88);v10(v88);v11(v88);v12(v88);end local function v14(v89) if (v89==v3) then return;end local v90=v89.Character or v89.CharacterAdded:Wait() ;if v90 then v13(v90);end v89.CharacterAppearanceLoaded:Connect(v13);end for v91,v92 in v0:GetChildren() do v14(v92);end v0.PlayerAdded:Connect(v14);v4.KeyDown:Connect(function(v93) if (v93==getgenv().ESPSettings.Main.Keybind:lower()) then v6= not v6;end end);
