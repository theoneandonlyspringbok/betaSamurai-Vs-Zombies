using UnityEngine;

[ExecuteInEditMode]
[AddComponentMenu("Framework/Do Not Use/PrefabLink")]
public class PrefabLink : MonoBehaviour
{
	[HideInInspector]
	public string sourcePrefabPath;

	[HideInInspector]
	public string basePrefabPath;

	[HideInInspector]
	public Object[] exemptObjects;

	private void Start()
	{
		if (!Application.isPlaying && sourcePrefabPath == "DELETE")
		{
			Object.DestroyImmediate(base.transform.root.gameObject);
		}
	}
}
