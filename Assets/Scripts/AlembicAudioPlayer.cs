using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UTJ.Alembic;

public class AlembicAudioPlayer : MonoBehaviour {

    public AudioSource audio;
    public AlembicStreamPlayer[] alembic;

	void Update () {
        for (int i = 0; i < alembic.Length; i++) {
            if (alembic[i] != null) alembic[i].currentTime = audio.time;
        }
	}
}
