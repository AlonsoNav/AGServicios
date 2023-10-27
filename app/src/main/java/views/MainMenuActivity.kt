package views

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import com.hytan.agserviciosv1.R

class MainMenuActivity : AppCompatActivity() {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main_menu)

        val volver = findViewById<Button>(R.id.buttonVolver)
      volver.setOnClickListener{
            val volver = Intent(this,LoginActivity::class.java)

          startActivity(volver)
          finish()
        }
    }
}