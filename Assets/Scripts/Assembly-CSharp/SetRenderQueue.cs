using UnityEngine;

[RequireComponent(typeof(Renderer))]
[AddComponentMenu("Effects/SetRenderQueue")]
public class SetRenderQueue : MonoBehaviour
{
	public int queue = 1;

	public int[] queues;

	protected void Start()
	{
		if ((bool)base.renderer && (bool)base.renderer.sharedMaterial && queues != null)
		{
			base.renderer.sharedMaterial.renderQueue = queue;
			for (int i = 0; i < queues.Length && i < base.renderer.sharedMaterials.Length; i++)
			{
				base.renderer.sharedMaterials[i].renderQueue = queues[i];
			}
		}
	}
}
