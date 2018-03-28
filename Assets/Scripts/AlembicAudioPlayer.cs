using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UTJ.Alembic;

public class AlembicAudioPlayer : MonoBehaviour {

    public AudioSource audio;
    public AlembicStreamPlayer alembic;

	void Update () {
        alembic.currentTime = audio.time;
	}
}
