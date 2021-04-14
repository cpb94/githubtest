$PBExportHeader$wi_mant_prommapapaneles.srw
forward
global type wi_mant_prommapapaneles from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_prommapapaneles
end type
type dw_paneles from datawindow within wi_mant_prommapapaneles
end type
type uo_panel from u_em_campo_2 within wi_mant_prommapapaneles
end type
type st_3 from statictext within wi_mant_prommapapaneles
end type
end forward

global type wi_mant_prommapapaneles from wi_mvent_con_empresa
integer width = 2921
integer height = 1624
pb_calculadora pb_calculadora
dw_paneles dw_paneles
uo_panel uo_panel
st_3 st_3
end type
global wi_mant_prommapapaneles wi_mant_prommapapaneles

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

forward prototypes
public subroutine f_calculo_linea ()
public subroutine f_calculo_total ()
end prototypes

public subroutine f_calculo_linea ();IF dw_1.GetRow() =0 then Return
dw_1.AcceptText()

String articulo,calidad,formato,var_empresa,var_articulo,var_calidad

Dec{2} peso,cantidad,var_precio
Dec{2} venta,coste
Dec{0} piezas

articulo = dw_1.GetItemString(dw_1.GetRow(),"articulo")
piezas = dw_1.GetItemNumber(dw_1.GetRow(),"piezas")

cantidad = f_conversion_piezas_cantidad_bis(codigo_empresa,articulo,piezas)

calidad  = f_calidad_promparam(codigo_empresa)
formato  = f_formato_articulo(codigo_empresa,articulo)
peso     = f_peso_articulo(codigo_empresa,articulo)
coste    = f_coste_articulo(codigo_empresa,articulo)
IF IsNull(coste) Then coste = 0
IF IsNull(peso) Then peso = 0

venta  = &
f_precio_articulo_venlintarifas(codigo_empresa,&
                           	  f_tarifa_promparam(codigo_empresa),&
								        f_activa_ventarifas(codigo_empresa,f_tarifa_promparam(codigo_empresa)),&
										  articulo,f_calidad_promparam(codigo_empresa)) * cantidad
IF IsNull(venta) Then venta = 0										  
coste   = coste  *  cantidad
peso    = peso   *  piezas
venta   = venta 

dw_1.SetItem(dw_1.GetRow(),"coste",coste)
dw_1.SetItem(dw_1.GetRow(),"pventa",venta)
dw_1.SetItem(dw_1.GetRow(),"peso",peso)

end subroutine

public subroutine f_calculo_total ();String panel
Dec{2}  coste,peso,venta

panel = uo_panel.em_codigo.text
  SELECT  sum(prommapapaneles.peso),sum(prommapapaneles.coste),
          sum(prommapapaneles.pventa)  
    INTO  :peso,:coste,:venta
    FROM  prommapapaneles  
   WHERE (prommapapaneles.empresa = :codigo_empresa ) AND  
         (prommapapaneles.codigo = :panel );

  UPDATE prompaneles  
     SET pesomaterial = :peso,  
         pventamaterial = :venta, 
         costematerial = :coste  
   WHERE ( prompaneles.empresa = :codigo_empresa ) AND  
         ( prompaneles.codigo = :panel )   ;
   COMMIT;


end subroutine

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de paneles por expositor"
	istr_parametros.s_listado        = "report_prommapapaneles"
   This.title = istr_parametros.s_titulo_ventana
   dw_paneles.SetTransObject(Sqlca)
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      uo_panel.em_codigo.text=istr_parametros.s_argumentos[2]
      uo_panel.em_campo.text= f_nombre_prompaneles(codigo_empresa,uo_panel.em_codigo.text)
      dw_paneles.Retrieve(codigo_empresa,uo_panel.em_codigo.text)
      f_activar_campo(sle_valor)
		//Return
	else
		f_activar_campo(uo_panel.em_campo)
   END IF
   


	
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
dw_paneles.enabled = TRUE
uo_panel.enabled = TRUE
end on

on ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(uo_panel.em_codigo.text))
criterio[2]   =  trim(uo_panel.em_codigo.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "prompaneles"

dw_1.Retrieve(codigo_empresa,uo_panel.em_codigo.text,Integer(sle_valor.Text))
dw_paneles.Retrieve(codigo_empresa,uo_panel.em_codigo.text)


CALL Super::ue_recuperar
end on

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",uo_panel.em_codigo.text)
   dw_1.setitem(dw_1.getrow(),"linea",Integer(sle_valor.text))
   dw_1.setitem(dw_1.getrow(),"falta",DateTime(Today()))
	// La calidad siempre la grabaremos de los paramatros
   dw_1.setitem(dw_1.getrow(),"calidad",f_calidad_promparam(codigo_empresa))
   dw_1.setitem(dw_1.getrow(),"usuario",nombre_usuario)
  
end event

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
dw_paneles.enabled = FALSE
uo_panel.enabled = FALSE
end on

on wi_mant_prommapapaneles.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dw_paneles=create dw_paneles
this.uo_panel=create uo_panel
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dw_paneles
this.Control[iCurrent+3]=this.uo_panel
this.Control[iCurrent+4]=this.st_3
end on

on wi_mant_prommapapaneles.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dw_paneles)
destroy(this.uo_panel)
destroy(this.st_3)
end on

on ue_actualiza_dw;Dec{2} largo,ancho
String  expositor
Integer linea
String montajeartcal,articulo,calidad
articulo = dw_1.GetItemString(dw_1.GetRow(),"articulo")
calidad  = dw_1.GetItemString(dw_1.GetRow(),"calidad")
montajeartcal = f_componer_artcal(articulo,calidad)
dw_1.SetItem(dw_1.GetRow(),"montajeartcal",montajeartcal)
CALL super::ue_actualiza_dw
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_prommapapaneles
integer x = 23
integer y = 280
integer width = 2373
integer height = 628
string dataobject = "dw_prommapapaneles"
end type

on dw_1::itemfocuschanged;call wi_mvent_con_empresa`dw_1::itemfocuschanged;f_calculo_linea()
end on

on dw_1::key;bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "articulo"
      bus_titulo     = "VENTANA SELECCION DE ARTICULOS"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_articulos"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::key
end on

on dw_1::valores_numericos;call wi_mvent_con_empresa`dw_1::valores_numericos;f_valores_numericos(dw_1,"articulo")
end on

on dw_1::rbuttondown; bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "articulo"
      bus_titulo     = "VENTANA SELECCION DE ARTICULOS"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_articulos"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end on

event dw_1::clicked;call super::clicked;f_calculo_linea()
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;f_calculo_linea()
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_prommapapaneles
integer x = 1422
integer y = 180
integer width = 242
string text = "Linea:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_prommapapaneles
integer x = 2432
integer y = 304
end type

event cb_insertar::clicked;dw_1.AcceptText()
f_calculo_linea()

Call Super::Clicked

f_calculo_total()
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_prommapapaneles
integer x = 2432
integer y = 424
end type

on cb_borrar::clicked;call wi_mvent_con_empresa`cb_borrar::clicked;f_calculo_total()
end on

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_prommapapaneles
integer x = 1678
integer y = 168
integer taborder = 30
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;IF Trim(uo_panel.em_campo.text) = "" Then f_activar_campo(uo_panel.em_campo)
isle_campo    = This
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_prommapapaneles
integer x = 2432
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_prommapapaneles
integer taborder = 40
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_prommapapaneles
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_prommapapaneles
integer width = 2816
end type

type pb_calculadora from u_calculadora within wi_mant_prommapapaneles
integer x = 1943
integer y = 168
integer taborder = 0
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
String panel
  panel =  uo_panel.em_codigo.text
 Select count(*) Into :registros From prommapapaneles
 Where  prommapapaneles.empresa = :codigo_empresa
 And    prommapapaneles.codigo = :panel;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,prommapapaneles.linea)+1)
  Into   :sle_valor.text
  From   prommapapaneles
  Where  prommapapaneles.empresa = :codigo_empresa
  And    prommapapaneles.codigo = :panel;
 END IF
 dw_1.TriggerEvent("Clicked")
end event

type dw_paneles from datawindow within wi_mant_prommapapaneles
integer x = 23
integer y = 908
integer width = 2377
integer height = 508
boolean bringtotop = true
string dataobject = "dw_prommapapaneles2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF Row =0 Then 
 f_activar_campo(uo_panel.em_campo)
 Return
END IF

sle_valor.text = String(This.GetItemNumber(Row,"linea"))
Parent.TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)
end event

type uo_panel from u_em_campo_2 within wi_mant_prommapapaneles
integer x = 526
integer y = 168
integer width = 873
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de paneles"
ue_datawindow = "dw_ayuda_prompaneles"
ue_filtro     = ""
end on

event modificado;call super::modificado;uo_panel.em_campo.text=f_nombre_prompaneles(codigo_empresa,uo_panel.em_codigo.text)
IF Trim(uo_panel.em_campo.text)="" THEN 
 IF Trim(uo_panel.em_codigo.text)<>"" Then uo_panel.em_campo.SetFocus()
 uo_panel.em_campo.text=""
 uo_panel.em_codigo.text=""
eND IF
dw_paneles.Retrieve(codigo_empresa,uo_panel.em_codigo.text)

 
end event

on uo_panel.destroy
call u_em_campo_2::destroy
end on

type st_3 from statictext within wi_mant_prommapapaneles
integer x = 283
integer y = 176
integer width = 219
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Panel:"
alignment alignment = right!
boolean focusrectangle = false
end type

