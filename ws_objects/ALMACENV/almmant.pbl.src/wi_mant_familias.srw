$PBExportHeader$wi_mant_familias.srw
$PBExportComments$Mantenimiento de familias.
forward
global type wi_mant_familias from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_familias
end type
type dw_detalle from datawindow within wi_mant_familias
end type
type gb_1 from groupbox within wi_mant_familias
end type
type dw_cuentas from datawindow within wi_mant_familias
end type
end forward

global type wi_mant_familias from wi_mvent_con_empresa
integer width = 2962
integer height = 1440
pb_calculadora pb_calculadora
dw_detalle dw_detalle
gb_1 gb_1
dw_cuentas dw_cuentas
end type
global wi_mant_familias wi_mant_familias

type variables
DataWindowChild  idwc_lineas
end variables

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"decorado","N")
dw_1.setitem(dw_1.getrow(),"tono","S")
dw_1.setitem(dw_1.getrow(),"calibre","S")
dw_1.setitem(dw_1.getrow(),"sector","S")
dw_1.setitem(dw_1.getrow(),"tipo_unidad","0")

end event

on ue_actualiza_dw;call wi_mvent_con_empresa::ue_actualiza_dw;dw_detalle.Retrieve(codigo_empresa,sle_valor.Text)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Familias"
istr_parametros.s_listado        = "report_familias"
This.title=istr_parametros.s_titulo_ventana
dw_detalle.SetTransObject(SQLCA)   
dw_cuentas.SetTransObject(SQLCA)   
// Si recibo el codigo lo visualizo
  IF istr_parametros.i_nargumentos>1 THEN
     sle_valor.text=istr_parametros.s_argumentos[2]
     IF Trim(sle_valor.text)<>"" THEN
       This.TriggerEvent("ue_recuperar")
	  END IF
  END IF


end event

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        = This.title
longitud		 = len(trim(codigo_empresa))
criterio[1]	 = trim(codigo_empresa)+ space(20-longitud)
longitud  	 = len(trim(sle_valor.text))
criterio[2]  = trim(sle_valor.text)+space(20-longitud)
seleccion  	 = criterio[1]+criterio[2]
tabla     	 = "familias"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

dw_detalle.Retrieve(codigo_empresa,sle_valor.Text)

dw_cuentas.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on wi_mant_familias.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dw_detalle=create dw_detalle
this.gb_1=create gb_1
this.dw_cuentas=create dw_cuentas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dw_detalle
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.dw_cuentas
end on

on wi_mant_familias.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dw_detalle)
destroy(this.gb_1)
destroy(this.dw_cuentas)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_familias
integer x = 9
integer y = 216
integer width = 1550
integer height = 936
string dataobject = "dw_familias"
boolean border = true
end type

event dw_1::rbuttondown;
 bus_filtro=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
	CASE "linea"
      bus_titulo     = "VENTANA SELECCION DE LINEAS DE FABRICACION "
 		bus_datawindow = "dw_ayuda_lineasfab"
 	   valor_empresa = TRUE
  	CASE "tipo_unidad"
      bus_titulo     = "VENTANA SELECCION DE UNIDADES"
 		bus_datawindow = "dw_ayuda_unidades"
	   valor_empresa = FALSE
  	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown


end event

event dw_1::key; bus_filtro=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
	CASE "linea"
      bus_titulo     = "VENTANA SELECCION DE LINEAS DE FABRICACION "
 		bus_datawindow = "dw_ayuda_lineasfab"
 	   valor_empresa = TRUE
 	CASE "tipo_unidad"
      bus_titulo     = "VENTANA SELECCION DE LINEAS DE FABRICACION "
 		bus_datawindow = "dw_ayuda_unidades"
	   valor_empresa = FALSE
  	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key





end event

event dw_1::clicked;call super::clicked;string ls_objeto
datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = TRIM(F_OBJETO_DATAWINDOW(THIS))

//ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_almacenes"

CHOOSE CASE ls_objeto 
	CASE 'pb_linea'
		lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"linea")
		OpenWithParm(wi_mant_lineasfab,lstr_param)
	CASE 'pb_tipo_unidad'
		lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"tipo_unidad")
		OpenWithParm(wi_mant_unidades,lstr_param)
END CHOOSE





end event

event dw_1::valores_numericos;call super::valores_numericos;f_valores_numericos(This,"linea")
f_valores_numericos(This,"tipo_unidad")
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_familias
integer x = 201
integer y = 100
integer width = 251
string text = "Familia"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_familias
integer x = 137
integer y = 1184
integer height = 84
end type

on cb_insertar::clicked;IF cb_insertar.enabled=TRUE THEN

  			dw_1.AcceptText()
			string ls_tono,ls_calibre,ls_sector

			ls_tono    = dw_1.GetItemString(dw_1.GetRow(),'tono')
 		   ls_calibre = dw_1.GetItemString(dw_1.GetRow(),'calibre')
         ls_sector  = dw_1.GetItemString(dw_1.GetRow(),'sector')
         IF ls_sector = "N" and (ls_calibre="S" or ls_tono="S") Then
	           MessageBox("La familia no es del Sector","Esta familia no puede llevar tono ni calibre ",Exclamation!, OK!,1)
				  dw_1.SetColumn('sector')
				  dw_1.SetRow(dw_1.GetRow())
				  dw_1.SetFocus()
         END IF


			IF (ls_tono<>"S" and ls_tono<>"N") or IsNull(ls_tono) or trim(ls_tono)="" THEN
	           MessageBox("Dato erroneo","Debe ser S ó N",Exclamation!, OK!,1)
				  dw_1.SetColumn('tono')
				  dw_1.SetRow(dw_1.GetRow())
				  dw_1.SetFocus()
              RETURN 
        END IF
		

   	  IF (ls_calibre<>"S" and ls_calibre<>"N") or IsNull(ls_calibre) or trim(ls_calibre)="" THEN
	           MessageBox("Dato erroneo","Debe ser S ó N",Exclamation!, OK!,1)
				  dw_1.SetColumn('calibre')
				  dw_1.SetRow(dw_1.GetRow())
				  dw_1.SetFocus()
              RETURN 
        END IF
		
end if

CALL Super::Clicked


end on

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_familias
integer x = 549
integer y = 1184
integer height = 84
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_familias
integer y = 96
long backcolor = 16777215
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;ue_titulo     = "Ayuda selección familias"
ue_datawindow = "dw_ayuda_familias"
ue_filtro     = ""
isle_campo    = This
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_familias
integer x = 960
integer y = 1184
integer height = 84
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_familias
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_familias
integer y = 88
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_familias
integer width = 2176
end type

type pb_calculadora from u_calculadora within wi_mant_familias
integer x = 759
integer y = 92
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
Integer registros
Select count(*) Into :registros From familias
Where  familias.empresa  = :codigo_empresa;
If registros=0 Then
   sle_valor.text="1"
Else
   Select max(convert(int,familias.codigo)+1)
   Into   :sle_valor.text
   From   familias
   Where  familias.empresa = :codigo_empresa;
End If
dw_1.TriggerEvent("Clicked")
end on

type dw_detalle from datawindow within wi_mant_familias
integer x = 1563
integer y = 652
integer width = 1385
integer height = 500
boolean bringtotop = true
string dataobject = "dw_familias3"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;string ls_objeto
str_parametros lstr_param

		// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
      // el numero de fila en la Datawindow

ls_objeto = F_OBJETO_DATAWINDOW(THIS)

//ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)

CHOOSE CASE ls_objeto

   CASE 'pb_carpeta'

			lstr_param.s_titulo_ventana = "Mantenimiento de Calidades por Formato"
			lstr_param.s_argumentos[1]  = "wi_mant_familias"
         lstr_param.s_argumentos[2]  = sle_valor.Text
	      lstr_param.i_nargumentos    = 2
         
			OpenWithParm(wi_mant_venincrempais, lstr_param)

END CHOOSE

f_activar_campo(sle_valor)

end event

type gb_1 from groupbox within wi_mant_familias
integer x = 128
integer y = 1152
integer width = 1253
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type dw_cuentas from datawindow within wi_mant_familias
integer x = 1563
integer y = 216
integer width = 1385
integer height = 412
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_vencuentasegunfam2"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param

if not(cb_insertar.enabled) then
	lstr_param.s_titulo_ventana = "Mantenimiento de Familias"
	lstr_param.s_argumentos[1]  = "wi_mant_familias"
	lstr_param.s_argumentos[2]  = sle_valor.Text
	lstr_param.i_nargumentos    = 2
	
	OpenWithParm(wi_mant_vencuentasegunfam, lstr_param)
	
	dw_cuentas.Retrieve(codigo_empresa,sle_valor.Text)

end if


end event

