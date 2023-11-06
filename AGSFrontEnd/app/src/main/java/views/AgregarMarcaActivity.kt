package views

import android.app.Dialog
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import com.hytan.agserviciosv1.R

class AgregarMarcaActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_agregar_marca)

        //pop up
        val dialog = Dialog(this)
        dialog.getWindow()?.setBackgroundDrawableResource(android.R.color.transparent);
        dialog.getWindow()?.getAttributes()?.windowAnimations = R.style.CustomDialogAnimation
        dialog.setContentView(R.layout.popupinformativo)
        dialog.setCancelable(true)

        //Volver
        val volver = findViewById<Button>(R.id.buttonVolverAgregarMarca)
        volver.setOnClickListener {
            val volver = Intent(this, MenuGestionSistemaActivity::class.java)
            startActivity(volver)
            finish()
        }

        //registrar marca
        val agregar = findViewById<Button>(R.id.buttonAgregarMarca)
        agregar.setOnClickListener {
            val buttonClose = dialog.findViewById<Button>(R.id.buttonListoPUP)
            val textViewPopup = dialog.findViewById<TextView>(R.id.textViewPUP)

            textViewPopup.text = "Marca agregada con éxito."
            buttonClose.setOnClickListener {
                dialog.dismiss()
            }
            dialog.show()
        }
    }
}