package views


import android.app.Dialog
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ArrayAdapter
import android.widget.Button
import android.widget.ListView
import android.widget.Spinner
import android.widget.TextView
import com.hytan.agserviciosv1.R

class ConsultarMaquinaActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_consultar_maquina)

        val volverCM = findViewById<Button>(R.id.buttonVolverConsultarMaquina)
        val consultar = findViewById<Button>(R.id.buttonConsultarMaquina)

        val dialog = Dialog(this)
        dialog.setContentView(R.layout.popup_display)
        dialog.setCancelable(true)

        dialog.getWindow()
            ?.setBackgroundDrawableResource(android.R.color.transparent);
        dialog.getWindow()?.getAttributes()?.windowAnimations =
            R.style.CustomDialogAnimation

        volverCM.setOnClickListener{

            val volverCM = Intent(this, MenuGestionSistemaActivity::class.java)
            startActivity(volverCM)
            finish()
        }

        consultar.setOnClickListener {

            val listo = dialog.findViewById<Button>(R.id.buttonListoPUPDisplay)
            val textDisplay = dialog.findViewById<TextView>(R.id.textViewPUPDisplay)
            val lista = dialog.findViewById<ListView>(R.id.listViewDisplay)
            val items = arrayOf("Item 11111111111111111111111111111111111111111111111111111111111111111111111111111111111", "Item 2", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3")
            val adapter = ArrayAdapter(this, R.layout.list_text_color, items)
            lista.adapter = adapter
            textDisplay.text="Lista de máquinas"

            listo.setOnClickListener {
                dialog.dismiss()
            }
            dialog.show()

        }
    }
}