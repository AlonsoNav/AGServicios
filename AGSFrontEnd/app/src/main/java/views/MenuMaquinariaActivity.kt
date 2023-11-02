package views

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import com.hytan.agserviciosv1.R

class MenuMaquinariaActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_menu_maquinaria)
        val volverGM = findViewById<Button>(R.id.buttonVolverGM)

        volverGM.setOnClickListener{
            val volverMM = Intent(this,MainMenuActivity::class.java)

            startActivity(volverMM)
            finish()
        }
    }

}