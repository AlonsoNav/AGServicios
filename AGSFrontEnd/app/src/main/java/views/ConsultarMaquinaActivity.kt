package views

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import com.hytan.agserviciosv1.R

class ConsultarMaquinaActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_consultar_maquina)

        val volverCM = findViewById<Button>(R.id.buttonVolverConsultarMaquina)

        volverCM.setOnClickListener{

            val volverCM = Intent(this, MenuGestionSistemaActivity::class.java)
            startActivity(volverCM)
            finish()
        }
    }
}