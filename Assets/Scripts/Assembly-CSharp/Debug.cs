using UnityEngine;

public static class Debug
{
	public static bool isDebugBuild = UnityEngine.Debug.isDebugBuild;

	private static bool debugActive = true;

	public static void Log(object message)
	{
		if (debugActive)
		{
			UnityEngine.Debug.Log(message);
		}
	}

	public static void Log(object message, Object context)
	{
		if (debugActive)
		{
			UnityEngine.Debug.Log(message, context);
		}
	}

	public static void LogError(object message)
	{
		if (debugActive)
		{
			UnityEngine.Debug.LogError(message);
		}
	}

	public static void LogError(object message, Object context)
	{
		if (debugActive)
		{
			UnityEngine.Debug.LogError(message, context);
		}
	}

	public static void LogWarning(object message)
	{
		if (debugActive)
		{
			UnityEngine.Debug.LogWarning(message);
		}
	}

	public static void LogWarning(object message, Object context)
	{
		if (debugActive)
		{
			UnityEngine.Debug.LogWarning(message, context);
		}
	}

	public static void DrawLine(Vector3 start, Vector3 end, Color color)
	{
		if (debugActive)
		{
			UnityEngine.Debug.DrawLine(start, end, color);
		}
	}

	public static void DrawRay(Vector3 start, Vector3 dir, Color color)
	{
		if (debugActive)
		{
			UnityEngine.Debug.DrawRay(start, dir, color);
		}
	}

	public static void Break()
	{
		if (debugActive)
		{
			UnityEngine.Debug.Break();
		}
	}
}
