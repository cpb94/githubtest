$PBExportHeader$wi_mant_promcabmapa.srw
forward
global type wi_mant_promcabmapa from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_promcabmapa
end type
type dw_paneles from datawindow within wi_mant_promcabmapa
end type
type pb_1 from upb_salir within wi_mant_promcabmapa
end type
type gb_1 from groupbox within wi_mant_promcabmapa
end type
type dw_detalle1 from datawindow within wi_mant_promcabmapa
end type
end forward

global type wi_mant_promcabmapa from wi_mvent_con_empresa
integer width = 2880
integer height = 1668
pb_calculadora pb_calculadora
dw_paneles dw_paneles
pb_1 pb_1
gb_1 gb_1
dw_detalle1 dw_detalle1
end type
global wi_mant_promcabmapa wi_mant_promcabmapa

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de Mapas Paneles de Mano"
	istr_parametros.s_listado        = "report_promcabmapa"
   This.title = istr_parametros.s_titulo_ventana

     dw_paneles.SetTransObject(Sqlca)
     dw_detalle1.SetTransObject(Sqlca)
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      
       dw_paneles.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF
   

	
end event

on ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "promcabmapa"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
 dw_paneles.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end on

event ue_borra_fila;call super::ue_borra_fila;String   mapa
mapa   = sle_valor.text
  DELETE FROM promlinmapa  
   WHERE ( promlinmapa.empresa = :codigo_empresa ) AND  
         ( promlinmapa.codigo = :mapa )   ;


end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
dw_paneles.enabled = TRUE
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
dw_paneles.enabled = FALSE
end on

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
   dw_1.setitem(dw_1.getrow(),"falta",DateTime(Today()))
end on

on wi_mant_promcabmapa.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dw_paneles=create dw_paneles
this.pb_1=create pb_1
this.gb_1=create gb_1
this.dw_detalle1=create dw_detalle1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dw_paneles
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.dw_detalle1
end on

on wi_mant_promcabmapa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dw_paneles)
destroy(this.pb_1)
destroy(this.gb_1)
destroy(this.dw_detalle1)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_promcabmapa
integer x = 14
integer y = 288
integer width = 2775
integer height = 508
string dataobject = "dw_promcabmapa"
end type

on dw_1::rbuttondown; bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipo"
      bus_titulo     = "VENTANA SELECCION DE TIPOS DE EXPOSITORES"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_promexpositores"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end on

on dw_1::key;bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipo"
      bus_titulo     = "VENTANA SELECCION DE TIPOS DE EXPOSITORES"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_promexpositores"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::key
end on

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_promcabmapa
integer x = 142
integer y = 192
integer width = 343
string text = "Cod. Mapa:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_promcabmapa
integer x = 1559
integer y = 184
integer height = 76
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_promcabmapa
integer x = 1966
integer y = 184
integer height = 76
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_promcabmapa
integer x = 485
integer y = 180
integer height = 92
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_promcabmapa"
ue_titulo     =  "AYUDA SELECCION MAPAS"
ue_filtro     =  ""
isle_campo    = This

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
dw_paneles.Retrieve(codigo_empresa,sle_valor.Text)

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_promcabmapa
integer x = 2373
integer y = 184
integer height = 76
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_promcabmapa
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_promcabmapa
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_promcabmapa
integer width = 2592
end type

type pb_calculadora from u_calculadora within wi_mant_promcabmapa
integer x = 750
integer y = 176
integer taborder = 0
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From promcabmapa
 Where  promcabmapa.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,promcabmapa.codigo)+1)
  Into   :sle_valor.text
  From   promcabmapa
  Where  promcabmapa.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end on

type dw_paneles from datawindow within wi_mant_promcabmapa
integer x = 14
integer y = 796
integer width = 1595
integer height = 628
boolean bringtotop = true
boolean titlebar = true
string title = "Paneles del Mapa"
string dataobject = "dw_promcabmapa2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;string ls_objeto
str_parametros lstr_param

		// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
      // el numero de fila en la Datawindow

ls_objeto = This.GetObjectAtPointer()

ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)

CHOOSE CASE ls_objeto
   CASE 'pb_carpeta'
			lstr_param.s_argumentos[1]  = "w_int_promcabmapa"
         lstr_param.s_argumentos[2]  = sle_valor.Text
	      lstr_param.i_nargumentos    = 2
         OpenWithParm(w_int_promlinmapa, lstr_param)
   CASE ELSE
         If Row=0 Then Return
         This.SelectRow(0,FALSE)
         This.SelectRow(Row,TRUE)
         dw_detalle1.Retrieve(codigo_empresa,GetItemString(Row,"panel"))
END CHOOSE


end event

event rbuttondown;If Row=0 Then Return
This.SelectRow(0,FALSE)
This.SelectRow(Row,TRUE)
end event

type pb_1 from upb_salir within wi_mant_promcabmapa
integer x = 2702
integer y = 36
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type gb_1 from groupbox within wi_mant_promcabmapa
integer x = 1550
integer y = 148
integer width = 1243
integer height = 120
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type dw_detalle1 from datawindow within wi_mant_promcabmapa
integer x = 1605
integer y = 796
integer width = 1179
integer height = 628
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle de los paneles"
string dataobject = "dw_promcabmapa3"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

