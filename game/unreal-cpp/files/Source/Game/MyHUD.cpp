#include "MyHUD.h"
#include "Engine/Canvas.h"

void AMyHUD::DrawHUD()
{
    Super::DrawHUD();

    if (Canvas)
    {
        FString ScoreText = FString::Printf(TEXT("Score: %d"), Score);

        // Draw shadow
        DrawText(ScoreText, FColor::Black, 12.0f, 12.0f, nullptr, 1.2f);
        // Draw text
        DrawText(ScoreText, FColor::White, 10.0f, 10.0f, nullptr, 1.2f);
    }
}
