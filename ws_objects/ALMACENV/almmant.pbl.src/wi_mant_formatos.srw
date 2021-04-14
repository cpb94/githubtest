$PBExportHeader$wi_mant_formatos.srw
$PBExportComments$Mantenimiento de Formatos
forward
global type wi_mant_formatos from wi_mvent_con_empresa
end type
type dw_pallets from datawindow within wi_mant_formatos
end type
type dw_calidades from datawindow within wi_mant_formatos
end type
type pb_calculadora from u_calculadora within wi_mant_formatos
end type
type dw_listado_formatos from u_datawindow within wi_mant_formatos
end type
type pb_imprimir_preli from picturebutton within wi_mant_formatos
end type
end forward

global type wi_mant_formatos from wi_mvent_con_empresa
integer x = 251
integer y = 64
integer width = 3113
integer height = 1448
dw_pallets dw_pallets
dw_calidades dw_calidades
pb_calculadora pb_calculadora
dw_listado_formatos dw_listado_formatos
pb_imprimir_preli pb_imprimir_preli
end type
global wi_mant_formatos wi_mant_formatos

type variables

end variables

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Formatos"
istr_parametros.s_listado        = "report_formatos"
This.title=istr_parametros.s_titulo_ventana
   
dw_pallets.SetTransObject(sqlca)
dw_calidades.SetTransObject(sqlca)
dw_listado_formatos.SetTransObject(sqlca)
// En Principio aparece en invisible, hasta indicar un formato

dw_pallets.visible = FALSE
dw_calidades.visible = FALSE


f_mascara_columna(dw_1,"piezascaja","###0")
f_mascara_columna(dw_1,"metroscaja","###.00")
f_mascara_columna(dw_1,"metroslcaja","###.00")
f_mascara_columna(dw_1,"pesoenvase","###.000")
f_mascara_columna(dw_1,"pesocaja","###.00")
f_mascara_columna(dw_1,"pesopieza","###.000")
f_mascara_columna(dw_1,"largo","###.00")
f_mascara_columna(dw_1,"ancho","###.00")
f_mascara_columna(dw_1,"espesor","###.00")

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
   istr_parametros.i_nargumentos=0
 	IF Trim(sle_valor.text)<>"" THEN
		 This.TriggerEvent("ue_recuperar")
		 Return
	END IF
END IF






end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
end on

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "formatos"


dw_1.Retrieve(codigo_empresa,sle_valor.Text)

//dw_pallets.visible = TRUE
//dw_pallets.Retrieve(codigo_empresa,sle_valor.Text)

dw_calidades.visible = TRUE
dw_calidades.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on wi_mant_formatos.create
int iCurrent
call super::create
this.dw_pallets=create dw_pallets
this.dw_calidades=create dw_calidades
this.pb_calculadora=create pb_calculadora
this.dw_listado_formatos=create dw_listado_formatos
this.pb_imprimir_preli=create pb_imprimir_preli
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pallets
this.Control[iCurrent+2]=this.dw_calidades
this.Control[iCurrent+3]=this.pb_calculadora
this.Control[iCurrent+4]=this.dw_listado_formatos
this.Control[iCurrent+5]=this.pb_imprimir_preli
end on

on wi_mant_formatos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_pallets)
destroy(this.dw_calidades)
destroy(this.pb_calculadora)
destroy(this.dw_listado_formatos)
destroy(this.pb_imprimir_preli)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_formatos
integer x = 27
integer y = 288
integer width = 3013
integer height = 456
string dataobject = "dw_formatos"
end type

on dw_1::rbuttondown;bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "familia"
      bus_titulo     = "VENTANA SELECCION DE FAMILIAS "
 		bus_datawindow = "dw_ayuda_familias"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end on

event dw_1::clicked;call super::clicked;//string ls_objeto
//Decimal{2} ld_pesocaja,ld_largo,ld_ancho
//Decimal{3} ld_pesopz, ld_pesoenv
//Integer li_numpz
//Decimal{2} ld_metroscaja,ld_metroslcaja
//String codigo
//
//dw_1.accepttext()
//
//		// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
//      // el numero de fila en la Datawindow
//
//ls_objeto = This.GetObjectAtPointer()
//ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)
//CHOOSE CASE ls_objeto
//END CHOOSE
//








  










end event

on dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "familia"
      bus_titulo     = "VENTANA SELECCION DE FAMILIAS "
 		bus_datawindow = "dw_ayuda_familias"
      bus_filtro     =""
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF

end on

on dw_1::itemfocuschanged;call wi_mvent_con_empresa`dw_1::itemfocuschanged;

CHOOSE CASE This.GetColumnName()

	CASE "descripcion"
			string ls_descripcion, ls_abreviado
			ls_descripcion = This.GetItemString(This.GetRow(),'descripcion')
			IF ls_descripcion = "" OR IsNull(ls_descripcion) THEN
			    	ls_abreviado = This.GetItemString(This.GetRow(),'abreviado')
					This.SetItem(This.GetRow(),'descripcion', ls_abreviado)
					END IF

				// Tenemos que poner el siguiente campo al dato que interviene
				// en el calculo
  
END CHOOSE
end on

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_formatos
integer x = 210
integer y = 160
integer width = 293
string text = "Formato"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_formatos
integer x = 1403
integer y = 160
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_formatos
integer y = 160
end type

on cb_borrar::clicked;call wi_mvent_con_empresa`cb_borrar::clicked;///////////////////////////////////////////////////////////////////////
//																							//
//		En caso de borrar un formato, se eliminan en cascada los			//
//		pallets en los que va envasado.											//
//			( Ver la relación en la Base de Datos )							//
//																							//
///////////////////////////////////////////////////////////////////////
end on

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_formatos
integer x = 539
integer y = 160
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;ue_titulo      = "AYUDA SELECCION DE FORMATOS"
ue_datawindow  = "dw_ayuda_formatos"
ue_filtro     = ""
isle_campo    = This
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_formatos
integer x = 2249
integer y = 160
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_formatos
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_formatos
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_formatos
integer x = 110
integer y = 48
integer width = 2921
integer height = 84
end type

type dw_pallets from datawindow within wi_mant_formatos
integer x = 73
integer y = 768
integer width = 1202
integer height = 416
boolean bringtotop = true
string dataobject = "dw_palformatos"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;string ls_objeto
str_parametros lstr_param

		// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
      // el numero de fila en la Datawindow

ls_objeto = This.GetObjectAtPointer()

ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)

CHOOSE CASE ls_objeto

   CASE 'pb_carpeta'

			lstr_param.s_titulo_ventana = "Mantenimiento de Pallets por Formato"
			lstr_param.s_titulo_ayuda   = "AYUDA SELECCION DE PALLETS POR FORMATOS"
			lstr_param.s_nom_datawindow = "dw_ayuda_palformato"
			lstr_param.s_argumentos[1]  = "wi_mant_palformato"
         lstr_param.s_argumentos[2]  = sle_valor.Text
	      lstr_param.i_nargumentos    = 2
			
			OpenWithParm(wi_mant_palformato, lstr_param)
			dw_pallets.Retrieve(codigo_empresa,sle_valor.Text)

END CHOOSE

end event

type dw_calidades from datawindow within wi_mant_formatos
integer x = 2139
integer y = 760
integer width = 846
integer height = 416
boolean bringtotop = true
string dataobject = "dw_cal_formatos"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;string ls_objeto
str_parametros lstr_param

		// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
      // el numero de fila en la Datawindow

ls_objeto = This.GetObjectAtPointer()

ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)

CHOOSE CASE ls_objeto

   CASE 'pb_carpeta'

			lstr_param.s_titulo_ventana = "Mantenimiento de Calidades por Formato"
			lstr_param.s_titulo_ayuda   = "AYUDA SELECCION DE CALIDADES POR FORMATOS"
			lstr_param.s_nom_datawindow = "dw_ayuda_calformato"
			lstr_param.s_argumentos[1]  = "wi_mant_calformato"
         lstr_param.s_argumentos[2]  = sle_valor.Text
	      lstr_param.i_nargumentos    = 2
         
			OpenWithParm(wi_mant_calformato, lstr_param)
			dw_calidades.Retrieve(codigo_empresa,sle_valor.Text)

END CHOOSE

end event

type pb_calculadora from u_calculadora within wi_mant_formatos
integer x = 809
integer y = 156
integer taborder = 0
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
Integer registros
Select count(*) Into :registros From formatos
Where  formatos.empresa = :codigo_empresa;
If registros=0 Then
  sle_valor.text="1"
Else
 Select max(convert(int,formatos.codigo)+1)
 Into   :sle_valor.text
 From   formatos
 Where  formatos.empresa = :codigo_empresa;
End If
dw_1.TriggerEvent("Clicked")
end on

type dw_listado_formatos from u_datawindow within wi_mant_formatos
boolean visible = false
integer x = 1463
integer y = 812
integer width = 622
integer height = 324
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_listado_formatos"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//str_parametros lstr_param
//integer metros_horno = 40
//dec v_ancho, v_largo
//string formato
//
//
//dw_1.enabled = false
//if not(cb_insertar.enabled) then
//	dw_1.triggerevent(clicked!)
//end if
//dw_1.enabled = True
//
//If row=0 Then Return
//
//choose case f_objeto_datawindow(this)
//	case "pb_metros"
//		formato = dw_velocidades.object.prodmetroshoralinea_formato[row]
//		
//		select ancho, largo
//		into :v_ancho, :v_largo
//		from formatos
//		where empresa = :codigo_empresa
//		and codigo = :formato;
//
//		dw_velocidades.object.metroshora[row] = round(metros_horno / ((v_largo * v_ancho) / 10000),0)
//end choose
//
//IF ue_marca_linea = TRUE and row > 0 Then
//  this.SetRow(row)
//END IF
//
//
end event

event itemchanged;//string linea
//
//CHOOSE CASE dwo.name
//	CASE "linea"
//		select descripcion
//		into :linea
//		from prodlineas
//		where empresa = :codigo_empresa
//		and codigo = :data;
//		dw_velocidades.object.prodlineas_resumido[row] = linea
//
//END CHOOSE
//
//
end event

event rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "linea"
		bus_titulo     = "AYUDA LINEAS DE PRODUCCION"
		bus_datawindow = "dw_ayuda_prodlineas"
		bus_filtro     = "" 	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "linea"
		bus_titulo     = "AYUDA LINEAS DE PRODUCCION"
		bus_datawindow = "dw_ayuda_prodlineas"
		bus_filtro     = "" 	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event ue_valores;call super::ue_valores;ue_marca_linea = True
end event

type pb_imprimir_preli from picturebutton within wi_mant_formatos
integer x = 2793
integer y = 164
integer width = 105
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\print.bmp"
alignment htextalign = left!
end type

event clicked;dw_listado_formatos.Retrieve(codigo_empresa)
f_imprimir_datawindow(dw_listado_formatos)


end event

