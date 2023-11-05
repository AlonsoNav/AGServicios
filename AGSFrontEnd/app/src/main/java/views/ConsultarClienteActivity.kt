package views

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import com.hytan.agserviciosv1.R

class ConsultarClienteActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_consultar_cliente)

        val volverCC = findViewById<Button>(R.id.buttonVolverConsultaCliente)

        volverCC.setOnClickListener{

            val volverCC = Intent(this, MenuGestionSistemaActivity::class.java)
            startActivity(volverCC)
            finish()
        }
    }
}