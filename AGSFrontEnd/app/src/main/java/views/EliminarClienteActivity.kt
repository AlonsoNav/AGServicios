package views

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import com.hytan.agserviciosv1.R

class EliminarClienteActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_eliminar_cliente)

        val volverEC = findViewById<Button>(R.id.buttonVolverEliminarCliente)

        volverEC.setOnClickListener{

            val volverEC = Intent(this, MenuGestionSistemaActivity::class.java)
            startActivity(volverEC)
            finish()
        }
    }
}