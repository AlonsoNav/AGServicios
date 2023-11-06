package views

import android.app.Dialog
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import com.hytan.agserviciosv1.R

class EditarMarcaActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_editar_marca)

        //Pop up
        val dialog = Dialog(this)
        dialog.setContentView(R.layout.popupinformativo)
        dialog.setCancelable(true)
        dialog.getWindow()?.setBackgroundDrawableResource(android.R.color.transparent)
        dialog.getWindow()?.getAttributes()?.windowAnimations = R.style.CustomDialogAnimation

        //Volver
        val volver = findViewById<Button>(R.id.buttonVolverEditarMarca)
        volver.setOnClickListener {
            val volver = Intent(this, MenuGestionSistemaActivity::class.java)
            startActivity(volver)
            finish()
        }

        //Editar TDM
        val editar = findViewById<Button>(R.id.buttonEditarMarca)
        editar.setOnClickListener {
            val buttonClose = dialog.findViewById<Button>(R.id.buttonListoPUP)
            val textViewPopup = dialog.findViewById<TextView>(R.id.textViewPUP)

            textViewPopup.text = "Tipo de maquinaria modificada con éxito"
            buttonClose.setOnClickListener {
                dialog.dismiss()
            }
            dialog.show()
        }
    }
}
