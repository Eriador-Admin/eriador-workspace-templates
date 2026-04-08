#pragma once

#include "CoreMinimal.h"
#include "GameFramework/GameModeBase.h"
#include "MyGameMode.generated.h"

/**
 * Game mode that sets up the default pawn and HUD classes.
 * Assign this in Project Settings > Maps & Modes > Default GameMode.
 */
UCLASS()
class AMyGameMode : public AGameModeBase
{
    GENERATED_BODY()

public:
    AMyGameMode();
};
