package views

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import androidx.compose.ui.text.InternalTextApi
import com.hytan.agserviciosv1.R

class EliminarMaquinaActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_eliminar_maquina)

        val volverEM = findViewById<Button>(R.id.buttonVolverEliminarMaquina)
        val eliminar = findViewById<Button>(R.id.buttonEliminarMaquina)
        val editSerial = findViewById<EditText>(R.id.editSerialEliminarMaquina)

        volverEM.setOnClickListener{
            val volverEm= Intent(this,MenuMaquinariaActivity::class.java)

            startActivity(volverEm)
            finish()
        }

        eliminar.setOnClickListener{
            val serial = editSerial.text.toString()

        }
    }
}