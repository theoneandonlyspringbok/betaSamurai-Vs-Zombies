using UnityEngine;

public class HeroControls
{
	public delegate void OnPlayerControlCallback();

	private Rect kMoveLeftTouchArea = new Rect(0f, 0f, SUIScreen.width / 2f, SUIScreen.height);

	private Rect kMoveRightTouchArea = new Rect(SUIScreen.width / 2f, 0f, SUIScreen.width / 2f, SUIScreen.height);

	public OnPlayerControlCallback onMoveLeft;

	public OnPlayerControlCallback onMoveRight;

	public OnPlayerControlCallback onDontMove;

	private bool mWasMoving;

	public void Update()
	{
		int num = 0;
		if (WeakGlobalInstance<SUIScreen>.instance.inputs.justTouched)
		{
			mWasMoving = false;
		}
		if (WeakGlobalInstance<SUIScreen>.instance.inputs.isTouching)
		{
			Vector2 position = WeakGlobalInstance<SUIScreen>.instance.inputs.position;
			if (mWasMoving || !WeakGlobalSceneBehavior<InGameImpl>.instance.HUD.IsTouchingHUD(position))
			{
				if (kMoveLeftTouchArea.Contains(position))
				{
					num = -1;
					mWasMoving = true;
				}
				else if (kMoveRightTouchArea.Contains(position))
				{
					num = 1;
					mWasMoving = true;
				}
			}
			else
			{
				mWasMoving = false;
			}
		}
		else
		{
			mWasMoving = false;
		}
		if (num < 0)
		{
			if (onMoveLeft != null)
			{
				onMoveLeft();
			}
		}
		else if (num > 0)
		{
			if (onMoveRight != null)
			{
				onMoveRight();
			}
		}
		else if (onDontMove != null)
		{
			onDontMove();
		}
	}
}
