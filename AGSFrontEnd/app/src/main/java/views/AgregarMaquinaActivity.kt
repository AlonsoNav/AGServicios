package views

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ArrayAdapter
import android.widget.Button
import android.widget.Spinner
import com.hytan.agserviciosv1.R

class AgregarMaquinaActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_agregar_maquina)

        val volverAgregM = findViewById<Button>(R.id.buttonVolverAgregarMaquina)
        val spinner = findViewById<Spinner>(R.id.spinnerMarcaAgregar) // Replace with your Spinner ID
        val items = arrayOf("Item 1", "Item 2", "Item 3") // Replace with your items

        val adapter = ArrayAdapter(this, R.layout.spinner_text_color, items)
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        spinner.adapter = adapter

        volverAgregM.setOnClickListener{
            val volverAgregM = Intent(this,MenuGestionSistemaActivity::class.java)
            startActivity(volverAgregM)
            finish()
        }
    }
}