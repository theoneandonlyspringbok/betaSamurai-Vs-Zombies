using UnityEngine;

public class PrizeTrigger : MonoBehaviour
{
	public enum PrizeColor
	{
		Red = 1,
		Green = 2,
		Blue = 3,
		Magenta = 4,
		Gold = 5,
		Cyan = 6
	}

	private PrizeColor mMyColor;

	private void Start()
	{
		ChooseRandomColor();
	}

	private void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.name == "Ball(Clone)")
		{
			Debug.Log(mMyColor.ToString());
			Object.Destroy(other.gameObject);
			ChooseRandomColor();
		}
	}

	private void ChooseRandomColor()
	{
		mMyColor = (PrizeColor)Random.Range(1, 6);
		switch (mMyColor)
		{
		case PrizeColor.Red:
			base.renderer.material.color = Color.red;
			break;
		case PrizeColor.Green:
			base.renderer.material.color = Color.green;
			break;
		case PrizeColor.Blue:
			base.renderer.material.color = Color.blue;
			break;
		case PrizeColor.Magenta:
			base.renderer.material.color = Color.magenta;
			break;
		case PrizeColor.Gold:
			base.renderer.material.color = Color.yellow;
			break;
		case PrizeColor.Cyan:
			base.renderer.material.color = Color.cyan;
			break;
		}
	}
}
