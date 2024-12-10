using UnityEngine;

public class ReviveSFX : MonoBehaviour
{
	private float mAudioVolume;

	private float mMusicVolume;

	private bool mAttemptingToQuit;

	private void Start()
	{
		mAudioVolume = SoundThemeManager.Instance.globalVolume;
		SoundThemeManager.Instance.globalVolume = 0f;
		base.audio.Play();
		GameObject gameObject = GameObject.Find("Main Camera");
		mMusicVolume = gameObject.audio.volume;
		gameObject.audio.volume = 0f;
		mAttemptingToQuit = false;
	}

	private void Update()
	{
	}

	private void OnApplicationQuit()
	{
		mAttemptingToQuit = true;
	}

	private void OnDestroy()
	{
		if (!mAttemptingToQuit)
		{
			SoundThemeManager.Instance.globalVolume = mAudioVolume;
			GameObject gameObject = GameObject.Find("Main Camera");
			gameObject.audio.volume = mMusicVolume;
		}
	}
}
