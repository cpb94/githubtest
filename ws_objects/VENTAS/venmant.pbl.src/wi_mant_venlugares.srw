$PBExportHeader$wi_mant_venlugares.srw
$PBExportComments$Mant. lugares de Orgigen y Destino.
forward
global type wi_mant_venlugares from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_venlugares
end type
type gb_1 from groupbox within wi_mant_venlugares
end type
end forward

global type wi_mant_venlugares from wi_mvent_con_empresa
integer width = 2848
integer height = 812
pb_calculadora pb_calculadora
gb_1 gb_1
end type
global wi_mant_venlugares wi_mant_venlugares

type variables

end variables

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE

end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE

end on

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de lugares"
	istr_parametros.s_listado        = "report_venludares"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

	
end event

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "venlugares"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
CALL Super::ue_recuperar
end event

on wi_mant_venlugares.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.gb_1
end on

on wi_mant_venlugares.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.gb_1)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_venlugares
integer x = 46
integer y = 280
integer width = 2693
integer height = 256
string dataobject = "dw_venlugares"
end type

event dw_1::valores_numericos;call super::valores_numericos;f_valores_numericos(dw_1,"pais")
f_valores_numericos(dw_1,"provincia")



end event

event dw_1::key; bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo

CASE "pais"
      bus_titulo     = "VENTANA SELECCION DE PAISES "
 		bus_datawindow = "dw_ayuda_paises"
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

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_carbancos"
CHOOSE CASE ls_objeto
  

CASE 'pb_pais'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   OpenWithParm(wi_mant_paises,lstr_param) 
CASE 'pb_provincia'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"provincia")
   OpenWithParm(wi_mant_provincias,lstr_param) 
CASE 'pb_codpostal'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"codpostal")
   OpenWithParm(wi_mant_codpostales,lstr_param) 

END CHOOSE






end event

event dw_1::rbuttondown; bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "pais"
      bus_titulo     = "VENTANA SELECCION DE PAISES "
 		bus_datawindow = "dw_ayuda_paises"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_venlugares
integer x = 82
integer y = 176
integer width = 366
string text = "Lugar:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_venlugares
integer x = 1481
integer y = 168
integer height = 84
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_venlugares
integer x = 1897
integer y = 168
integer height = 84
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_venlugares
integer x = 466
integer y = 176
end type

event sle_valor::getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_venbancredit"
   ue_titulo         = "AYUDA SELECCION DE BANCOS AVISADORES"
   ue_filtro         = ""
   isle_campo        = This
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_venlugares
integer x = 2313
integer y = 168
integer height = 84
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_venlugares
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_venlugares
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_venlugares
integer width = 2299
end type

type pb_calculadora from u_calculadora within wi_mant_venlugares
integer x = 731
integer y = 172
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From venlugares
 Where  venlugares.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,venlugares.codigo)+1)
  Into   :sle_valor.text
  From   venlugares
  Where  venlugares.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end event

type gb_1 from groupbox within wi_mant_venlugares
integer x = 1463
integer y = 132
integer width = 1275
integer height = 136
integer taborder = 101
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

