using UnityEngine;
using UnityEngine.Video;

public class IntroMovie : MonoBehaviour
{
	private int mStaggeredOperationsPerUpdates;

	public VideoPlayer videoPlayer;

    public AudioSource audioSource;

    public VideoClip Glu_logo_1024x768;

    public VideoClip Glu_logo_960x640;

	public VideoClip Glu_logo_480x320;


    bool isPlaying;

	private void Start()
	{
        if (videoPlayer == null)
        {
            videoPlayer = GetComponent<VideoPlayer>();
        }
        if (audioSource == null)
        {
            audioSource = GetComponent<AudioSource>();
        }

        videoPlayer.audioOutputMode = VideoAudioOutputMode.AudioSource;
        videoPlayer.SetTargetAudioSource(0, audioSource);
    }

	private void Update()
	{
		mStaggeredOperationsPerUpdates++;
		switch (mStaggeredOperationsPerUpdates)
		{
		case 4:
			NUF.AllowPortrait(false);
			break;
		case 8:
			StartMovie();
			break;
		case 15:
			NUF.AllowPortrait(true);
			break;
		case 21:
			Debug.Log("IntroMovie: main menu load");
			//Application.LoadLevel("StoryMoviePre");
			break;
		}

        if (!isPlaying)
        {
            if (videoPlayer.isPlaying) isPlaying = true;
            return;
        }
        if (!videoPlayer.isPlaying || Input.GetMouseButton(0) || Input.GetKeyDown(KeyCode.Space))
		{
            Application.LoadLevel("StoryMoviePre");
        }
    }

	private void StartMovie()
	{
        /*string text = "1024x768";
		switch (Screen.width)
		{
		case 640:
			text = "960x640";
			break;
		case 320:
			text = "480x320";
			break;
		}
		string text2 = "Glu_logo_" + text + ".mp4";
		Debug.Log("Playing movie:" + text2);*/
        if (Screen.width >= 1024)
        {
            videoPlayer.clip = Glu_logo_1024x768;
            videoPlayer.Play();
        }
        else if (Screen.width >= 960 && Screen.width < 1024)
		{
			videoPlayer.clip = Glu_logo_960x640;
			videoPlayer.Play();
		}
        else if (Screen.width >= 480 && Screen.width < 960)
        {
            videoPlayer.clip = Glu_logo_480x320;
            videoPlayer.Play();
        }
		else
		{
            videoPlayer.clip = Glu_logo_480x320;
            videoPlayer.Play();
        }
    }
}
