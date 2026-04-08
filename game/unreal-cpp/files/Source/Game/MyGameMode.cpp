#include "MyGameMode.h"
#include "MyCharacter.h"
#include "MyHUD.h"

AMyGameMode::AMyGameMode()
{
    DefaultPawnClass = AMyCharacter::StaticClass();
    HUDClass = AMyHUD::StaticClass();
}
