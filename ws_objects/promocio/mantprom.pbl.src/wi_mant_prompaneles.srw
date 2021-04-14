$PBExportHeader$wi_mant_prompaneles.srw
forward
global type wi_mant_prompaneles from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_prompaneles
end type
type dw_detalle from datawindow within wi_mant_prompaneles
end type
type gb_1 from groupbox within wi_mant_prompaneles
end type
end forward

global type wi_mant_prompaneles from wi_mvent_con_empresa
integer width = 2917
integer height = 1636
pb_calculadora pb_calculadora
dw_detalle dw_detalle
gb_1 gb_1
end type
global wi_mant_prompaneles wi_mant_prompaneles

type variables
datawindowchild idw_nompro

end variables

forward prototypes
public subroutine f_control_campos ()
public subroutine f_calculo ()
end prototypes

public subroutine f_control_campos ();IF dw_1.GetRow() = 0 Then Return

dw_1.SetTabOrder("tipo_panel",40)
dw_1.SetTabOrder("medida",50)

dec{2} pesopanel
dec{0} preciocoste,precioventa
String mano
Integer int
Setnull(int)

mano  =  dw_1.GetItemString(dw_1.GetRow(),"panelmano")

IF mano = "S" THEN
 dw_1.SetTabOrder("medida",0)
 dw_1.SetTabOrder("tipo_panel",0)
 dw_1.SetItem(dw_1.GetRow(),"medida",int)
 dw_1.SetItem(dw_1.GetRow(),"tipo_panel",int)

 // Recojo los costes del panel de mano
//    pesopanel   = f_peso_panelmano(codigo_empresa)  
    preciocoste = f_preciocoste_panelmano(codigo_empresa)
    precioventa = f_precioventa_panelmano(codigo_empresa)
//	 dw_1.setitem(dw_1.getrow(),"peso",pesopanel)
    dw_1.setitem(dw_1.getrow(),"coste",preciocoste)
    dw_1.setitem(dw_1.getrow(),"pventa",precioventa)
END IF

end subroutine

public subroutine f_calculo ();String  expositor,mano,linea,var_tipo_panel,var_clase_panel,var_medida
Dec{2} coste,peso,venta,largo,ancho,coste_manipulacion
IF dw_1.GetRow() =0 Then Return

mano  =  dw_1.GetItemString(dw_1.GetRow(),"panelmano")

IF mano = "N" THEN

 var_tipo_panel    = dw_1.GetItemString(dw_1.GetRow(),"tipo_panel")
 var_medida        = dw_1.GetItemString(dw_1.GetRow(),"medida")
 var_clase_panel   = f_clase_panel_promparam(codigo_empresa)
 
 coste = f_preciocoste_promclasemedidas(codigo_empresa,var_clase_panel,var_medida)
 coste_manipulacion = f_costemanipulacion_prommedidas(codigo_empresa,var_medida)
 peso  = f_peso_promclasemedidas(codigo_empresa,var_clase_panel,var_medida)
 venta = f_precioventa_promclasemedidas(codigo_empresa,var_clase_panel,var_medida)
 largo = f_largo_prommedidas(codigo_empresa,var_medida)
 ancho = f_ancho_prommedidas(codigo_empresa,var_medida)
 
 dw_1.SetItem(dw_1.GetRow(),"coste",coste)
 dw_1.SetItem(dw_1.GetRow(),"costemanipulacion",coste_manipulacion)
// dw_1.SetItem(dw_1.GetRow(),"peso",peso)
 dw_1.SetItem(dw_1.GetRow(),"pventa",venta)
 dw_1.SetItem(dw_1.GetRow(),"largo",largo)
 dw_1.SetItem(dw_1.GetRow(),"ancho",ancho)
END IF

end subroutine

event ue_actualiza_dw;Dec{2} largo,ancho
f_control_campos()
f_calculo()
       

CALL super::ue_actualiza_dw
end event

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
   dw_1.setitem(dw_1.getrow(),"falta",DateTime(Today()))
   dw_1.setitem(dw_1.getrow(),"panelmano","N")
	dw_1.setitem(dw_1.getrow(),"grupo","0")
	dw_1.setitem(dw_1.getrow(),"activo","S")
end event

event ue_borra_fila;call super::ue_borra_fila;String panel
panel = sle_valor.text

  DELETE FROM prommapapaneles  
   WHERE ( prommapapaneles.empresa = :codigo_empresa ) AND  
         ( prommapapaneles.codigo = :panel )   ;

end event

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "prompaneles"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
dw_detalle.Retrieve(codigo_empresa,sle_valor.Text)
CALL Super::ue_recuperar
end event

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de paneles"
	istr_parametros.s_listado        = "report_prompaneles"
   This.title = istr_parametros.s_titulo_ventana
   
   dw_detalle.SetTransObject(Sqlca)
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
		istr_parametros.i_nargumentos=0
		IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
        dw_1.Retrieve(codigo_empresa,sle_valor.Text)
        dw_detalle.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF
   

	
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
dw_detalle.enabled = TRUE

end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
dw_detalle.enabled = FALSE
end on

on wi_mant_prompaneles.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dw_detalle=create dw_detalle
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dw_detalle
this.Control[iCurrent+3]=this.gb_1
end on

on wi_mant_prompaneles.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dw_detalle)
destroy(this.gb_1)
end on

event activate;call super::activate;wi_mant_prompaneles = ventanas_activas[id_ventana_activa].ventana
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_prompaneles
integer x = 23
integer y = 272
integer width = 2807
integer height = 720
string dataobject = "dw_prompaneles"
end type

event dw_1::valores_numericos;call super::valores_numericos;f_valores_numericos(dw_1,"grupo")
f_valores_numericos(dw_1,"medida")

end event

event dw_1::key; bus_filtro=""
 bus_campo = This.GetColumnName()
 
 CHOOSE CASE bus_campo
	CASE "medida"
      bus_titulo     = "VENTANA SELECCION MEDIDAS"
		bus_datawindow = "dw_ayuda_prommedidas"
	CASE "grupo"
      bus_titulo     = "VENTANA SELECCION DE GRUPOS"
      bus_datawindow = "dw_ayuda_promgrupos"
   CASE "tipo_panel"
		bus_filtro     = ""
      bus_titulo     = "VENTANA SELECCION TIPO PANELES"
      bus_datawindow = "dw_ayuda_promtipopanel"
CASE ELSE
		SetNull(bus_campo)
END CHOOSE
f_control_campos()
f_calculo()
 
CALL Super::key
end event

event dw_1::rbuttondown; bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "grupo"
      bus_titulo     = "VENTANA SELECCION DE GRUPOS"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_promgrupos"
    CASE "tipo_panel"
      bus_titulo     = "VENTANA SELECCION TIPO PANELES"
      bus_datawindow = "dw_ayuda_promtipopanel"
		bus_filtro     = ""
	CASE "medida"
      bus_titulo     = "VENTANA SELECCION MEDIDAS"
		bus_datawindow = "dw_ayuda_prommedidas"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_1::getfocus;call super::getfocus;IF GetRow() = 0 Then Return
string tipo_panel, cod_linea
cod_linea     = GetItemString(GetRow(),"tipo_panel")


end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_prompaneles
integer x = 279
integer y = 172
integer width = 206
string text = " Panel:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_prompaneles
integer x = 1586
integer y = 176
integer height = 76
end type

event cb_insertar::clicked;if cb_insertar.enabled = True then
	dw_1.Accepttext()	
	string var_panel,var_tipo,var_medida
	
	var_panel = dw_1.GetItemString(dw_1.Getrow(),"panelmano")
	var_tipo  = dw_1.GetItemString(dw_1.Getrow(),"tipo_panel")
	var_medida= dw_1.GetItemString(dw_1.Getrow(),"medida")
	
	if var_panel ="N" then 
	
		if len(trim(var_tipo))=0 or isnull(var_tipo) then
			MessageBox("Campo Obligatorio","Introducir Tipo de panel",Exclamation!, OK!,1)
			dw_1.SetColumn("tipo_panel")
			dw_1.setRow(dw_1.getRow())
			dw_1.setfocus()
			REturn
		End if
		if len(trim(var_medida))=0 or isnull(var_medida) then
			MessageBox("Campo Obligatorio","Introducir medida de panel",Exclamation!, OK!,1)
			dw_1.SetColumn("medida")
			dw_1.setRow(dw_1.getRow())
			dw_1.setfocus()
			REturn
		End if
	End if
	
End if

call super::clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_prompaneles
integer x = 1993
integer y = 176
integer height = 76
end type

event cb_borrar::clicked;Integer numero
String   panel
panel   = sle_valor.text
numero =0
Select count(*) Into :numero From prompanexpositores
Where  prompanexpositores.empresa   =   :codigo_empresa
And    prompanexpositores.panel     =   :panel;
If IsNull(numero) Then numero =0
If numero <> 0 then
  MessageBox("Proceso de borrado","No se puede borrar este panel mientras tenga expositores asignados",Exclamation!, OK!,1)
  f_activar_campo(sle_valor)
  Return
END IF

numero=0

Select count(*) Into :numero From promlinped
Where  promlinped.empresa   =   :codigo_empresa
And    promlinped.panel     =   :panel;
If IsNull(numero) Then numero =0
If numero <> 0 then
    MessageBox("Proceso de borrado","No se puede borrar este panel, tiene mvtos. Solo se puede desactivar",Exclamation!, OK!,1)
  f_activar_campo(sle_valor)
  Return
END IF

numero=0

Select count(*) Into :numero From prompedreposicion
Where  prompedreposicion.empresa   =   :codigo_empresa
And    prompedreposicion.panel     =   :panel;
If IsNull(numero) Then numero =0
If numero <> 0 then
  MessageBox("Proceso de borrado","No se puede borrar este panel, tiene mvtos. Solo se puede desactivar",Exclamation!, OK!,1)
  f_activar_campo(sle_valor)
  Return
END IF

Call super::clicked
end event

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_prompaneles
integer x = 507
integer y = 164
integer height = 92
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_prompaneles"
ue_titulo     =  "AYUDA SELECCION PANELES"
ue_filtro     =  ""
isle_campo    = This

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
dw_detalle.Retrieve(codigo_empresa,sle_valor.Text)

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_prompaneles
integer x = 2400
integer y = 176
integer height = 76
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_prompaneles
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_prompaneles
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_prompaneles
integer width = 2816
end type

type pb_calculadora from u_calculadora within wi_mant_prompaneles
integer x = 773
integer y = 164
integer taborder = 0
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From prompaneles
 Where  prompaneles.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,prompaneles.codigo)+1)
  Into   :sle_valor.text
  From   prompaneles
  Where  prompaneles.empresa = :codigo_empresa;
 END IF

 dw_1.TriggerEvent("Clicked")
end event

type dw_detalle from datawindow within wi_mant_prompaneles
integer x = 27
integer y = 988
integer width = 2807
integer height = 428
boolean bringtotop = true
string dataobject = "dw_prompaneles2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;
string ls_objeto
str_parametros lstr_param

		// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
      // el numero de fila en la Datawindow

ls_objeto = This.GetObjectAtPointer()

ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)

CHOOSE CASE ls_objeto

   CASE 'pb_carpeta'
			lstr_param.s_argumentos[1]  = "wi_mant_promexpositores"
         lstr_param.s_argumentos[2]  = sle_valor.Text
	      lstr_param.i_nargumentos    = 2
        OpenWithParm(wi_mant_prommapapaneles, lstr_param)

END CHOOSE

end event

type gb_1 from groupbox within wi_mant_prompaneles
integer x = 1577
integer y = 140
integer width = 1239
integer height = 120
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

