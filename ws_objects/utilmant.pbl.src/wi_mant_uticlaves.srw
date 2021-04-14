$PBExportHeader$wi_mant_uticlaves.srw
forward
global type wi_mant_uticlaves from wi_mant_ventanas
end type
type pb_calculadora from u_calculadora within wi_mant_uticlaves
end type
end forward

global type wi_mant_uticlaves from wi_mant_ventanas
integer x = 0
integer y = 0
integer width = 2651
integer height = 780
pb_calculadora pb_calculadora
end type
global wi_mant_uticlaves wi_mant_uticlaves

type variables



end variables

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de claves"
istr_parametros.s_listado        = "report_uticlaves"
valor_empresa = FALSE
This.title=istr_parametros.s_titulo_ventana

 // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
     sle_valor.text=istr_parametros.s_argumentos[2]
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
        	dw_1.Retrieve(sle_valor.text)
     END IF
END IF
end event

on ue_inserta_fila;call wi_mant_ventanas::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)

end on

on ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "uti_claves"
 dw_1.Retrieve(sle_valor.Text)
 CALL Super::ue_recuperar






end on

on ue_activa_claves;call wi_mant_ventanas::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on wi_mant_uticlaves.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_uticlaves.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_desactiva_claves;call wi_mant_ventanas::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_uticlaves
integer x = 46
integer y = 184
integer width = 2057
integer height = 300
string dataobject = "dw_uticlaves"
end type

on dw_1::rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "moneda"
 		bus_datawindow = "dw_ayuda_divisas"
		bus_titulo="AYUDA SELECCION DE MONEDAS"
   CASE "idioma"
      bus_datawindow = "dw_ayuda_idiomas"
		bus_titulo="AYUDA SELECCION DE IDIOMAS"
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown

end on

type st_1 from wi_mant_ventanas`st_1 within wi_mant_uticlaves
integer x = 183
integer y = 76
integer width = 265
integer height = 88
string text = "Código:"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_uticlaves
integer x = 2139
integer y = 188
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_uticlaves
integer x = 2139
integer y = 292
end type

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_uticlaves
integer x = 471
integer y = 76
integer taborder = 11
boolean bringtotop = true
end type

event sle_valor::getfocus;call super::getfocus;valor_empresa = False
ue_titulo   = "AYUDA SELECCION DE CLAVES"
ue_datawindow = "dw_ayuda_uticlaves"
ue_filtro = ""
isle_campo = this
end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_uticlaves
integer x = 2139
integer y = 396
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_uticlaves
end type

type pb_calculadora from u_calculadora within wi_mant_uticlaves
integer x = 736
integer y = 68
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
Integer registros
Select count(*) Into :registros From uti_claves;

IF registros=0  Then
   sle_valor.text="1"
 ELSE
   Select max(convert(int,uti_claves.codigo)+1) 
   Into   :sle_valor.text
   From   uti_claves;
END IF
dw_1.TriggerEvent("Clicked")
end on

