using UnrealBuildTool;

public class {{PROJECT_NAME}} : ModuleRules
{
    public {{PROJECT_NAME}}(ReadOnlyTargetRules Target) : base(Target)
    {
        PCHUsage = PCHUsageMode.UseExplicitOrSharedPCHs;

        PublicDependencyModuleNames.AddRange(new string[]
        {
            "Core",
            "CoreUObject",
            "Engine",
            "InputCore",
            "EnhancedInput",
            "UMG"
        });

        PrivateDependencyModuleNames.AddRange(new string[] { });
    }
}
