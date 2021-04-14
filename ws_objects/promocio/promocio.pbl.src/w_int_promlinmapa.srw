$PBExportHeader$w_int_promlinmapa.srw
forward
global type w_int_promlinmapa from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_promlinmapa
end type
type uo_mapa from u_em_campo_2 within w_int_promlinmapa
end type
type st_3 from statictext within w_int_promlinmapa
end type
type uo_grupo from u_em_campo_2 within w_int_promlinmapa
end type
type st_4 from statictext within w_int_promlinmapa
end type
type em_descripcion from u_em_campo within w_int_promlinmapa
end type
type st_8 from statictext within w_int_promlinmapa
end type
type dw_detalle from datawindow within w_int_promlinmapa
end type
type em_cantidad from u_em_campo within w_int_promlinmapa
end type
type st_9 from statictext within w_int_promlinmapa
end type
type dw_1 from u_datawindow_consultas within w_int_promlinmapa
end type
end forward

global type w_int_promlinmapa from w_int_con_empresa
integer width = 2875
integer height = 1672
pb_1 pb_1
uo_mapa uo_mapa
st_3 st_3
uo_grupo uo_grupo
st_4 st_4
em_descripcion em_descripcion
st_8 st_8
dw_detalle dw_detalle
em_cantidad em_cantidad
st_9 st_9
dw_1 dw_1
end type
global w_int_promlinmapa w_int_promlinmapa

type variables
string filtro
Integer  contador
editmask campo 
String marcado
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();
String descripcion,codpanel,var_tipo,cod_panel
Dec{0} numero,v_anyo,v_pedido
dw_1.Setfilter("")
dw_1.SetRedraw(False)
filtro = ""
descripcion = "%"+em_descripcion.text+"%"

IF marcado = "S" Then
	filtro = "control = 'X'"
	marcado= "S"
ELSE
	filtro = ""
	marcado = "N"
END IF
IF Trim(uo_grupo.em_codigo.text) <> "" and Not IsNull(uo_grupo.em_codigo.text) Then
	IF len(filtro) <>0 Then filtro = filtro + " And "
	 filtro = filtro +"grupo = '" + uo_grupo.em_codigo.text+"'"
END IF

dw_1.Setfilter(filtro)
dw_1.filter()
dw_1.Retrieve(codigo_empresa,descripcion,uo_mapa.em_codigo.text)

dw_1.SetRedraw(True)

if dw_1.GetRow()<>0 then
   cod_panel = dw_1.GetItemString(dw_1.Getrow(),"codigo")
   dw_detalle.Retrieve(codigo_empresa,cod_panel)
End if
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Introduccion Mapa Paneles de Mano"
This.title=istr_parametros.s_titulo_ventana
dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
dw_detalle.SetTransObject(SQLCA)
marcado= "N"
// Si recibo el codigo lo visualizo
iF istr_parametros.i_nargumentos>1 THEN
      uo_mapa.em_codigo.text=istr_parametros.s_argumentos[2]
      uo_mapa.em_campo.text=f_nombre_promcabmapa(codigo_empresa,istr_parametros.s_argumentos[2])
		uo_mapa.TriggerEvent("modificado")
		istr_parametros.i_nargumentos=0
		em_cantidad.text = "1"
      f_control()
		f_activar_campo(em_descripcion)
      Return
END IF

em_cantidad.text = "1"
f_control()
f_activar_campo(uo_mapa.em_campo)

end event

on w_int_promlinmapa.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_mapa=create uo_mapa
this.st_3=create st_3
this.uo_grupo=create uo_grupo
this.st_4=create st_4
this.em_descripcion=create em_descripcion
this.st_8=create st_8
this.dw_detalle=create dw_detalle
this.em_cantidad=create em_cantidad
this.st_9=create st_9
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_mapa
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.uo_grupo
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.em_descripcion
this.Control[iCurrent+7]=this.st_8
this.Control[iCurrent+8]=this.dw_detalle
this.Control[iCurrent+9]=this.em_cantidad
this.Control[iCurrent+10]=this.st_9
this.Control[iCurrent+11]=this.dw_1
end on

on w_int_promlinmapa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.uo_mapa)
destroy(this.st_3)
destroy(this.uo_grupo)
destroy(this.st_4)
destroy(this.em_descripcion)
destroy(this.st_8)
destroy(this.dw_detalle)
destroy(this.em_cantidad)
destroy(this.st_9)
destroy(this.dw_1)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event key;call super::key;
IF key = KeyEnter! Then f_control()
end event

event activate;call super::activate;w_int_promlinmapa = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_promlinmapa
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_promlinmapa
integer taborder = 20
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_descripcion)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_int_promlinmapa
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_int_promlinmapa
integer x = 2702
integer y = 4
integer width = 114
integer height = 108
integer taborder = 0
end type

type uo_mapa from u_em_campo_2 within w_int_promlinmapa
integer x = 59
integer y = 200
integer width = 864
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_mapa.em_campo.text=f_nombre_promcabmapa(codigo_empresa,uo_mapa.em_codigo.text)
IF Trim(uo_mapa.em_campo.text)="" THEN 
 IF Trim(uo_mapa.em_codigo.text)<>"" Then uo_mapa.em_campo.SetFocus()
 uo_mapa.em_campo.text=""
 uo_mapa.em_codigo.text=""
END IF

 
end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de mapas"
ue_datawindow = "dw_ayuda_promcabmapa"
ue_filtro     = ""
campo = uo_mapa.em_campo
end on

on uo_mapa.destroy
call u_em_campo_2::destroy
end on

type st_3 from statictext within w_int_promlinmapa
integer x = 55
integer y = 128
integer width = 869
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Mapa"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_grupo from u_em_campo_2 within w_int_promlinmapa
integer x = 923
integer y = 200
integer width = 416
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de grupos"
ue_datawindow = "dw_ayuda_promgrupos"
ue_filtro     = ""
campo = uo_grupo.em_campo
end on

event modificado;call super::modificado;uo_grupo.em_campo.text=f_nombre_promgrupos(codigo_empresa,uo_grupo.em_codigo.text)
IF Trim(uo_grupo.em_campo.text)="" THEN 
 IF Trim(uo_grupo.em_codigo.text)<>"" Then uo_grupo.em_campo.SetFocus()
 uo_grupo.em_campo.text=""
 uo_grupo.em_codigo.text=""
END IF


 
end event

on uo_grupo.destroy
call u_em_campo_2::destroy
end on

type st_4 from statictext within w_int_promlinmapa
integer x = 928
integer y = 128
integer width = 411
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Grupo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_descripcion from u_em_campo within w_int_promlinmapa
integer x = 1339
integer y = 200
integer width = 1093
integer taborder = 10
end type

on getfocus;call u_em_campo::getfocus;campo = this
end on

event modificado;call super::modificado;f_control()
end event

type st_8 from statictext within w_int_promlinmapa
integer x = 1344
integer y = 128
integer width = 1088
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Descripción"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_detalle from datawindow within w_int_promlinmapa
integer x = 64
integer y = 892
integer width = 2706
integer height = 524
boolean bringtotop = true
string dataobject = "dw_int_prompanexpositores5"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type em_cantidad from u_em_campo within w_int_promlinmapa
integer x = 2432
integer y = 200
integer width = 338
integer taborder = 0
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

on modificado;call u_em_campo::modificado;IF em_cantidad.text="" or em_cantidad.text="0" Then
em_cantidad.text="1"
END IF
end on

on getfocus;call u_em_campo::getfocus;campo = this
end on

type st_9 from statictext within w_int_promlinmapa
integer x = 2437
integer y = 128
integer width = 334
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cantidad"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_1 from u_datawindow_consultas within w_int_promlinmapa
integer x = 59
integer y = 292
integer width = 2711
integer height = 600
integer taborder = 0
string dataobject = "dw_int_promlinmapa1"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;call super::rowfocuschanged;String panel
IF dw_1.GetRow() =0 Then Return
panel = dw_1.GetItemString(dw_1.GetRow(),"codigo")
dw_detalle.Retrieve(codigo_empresa,panel)
end event

event doubleclicked;call super::doubleclicked;  Integer linea,lin,cantidad
  String mapa,panel,controles
  Dec{2}  pesomaterial,costematerial,ventamaterial
  mapa = uo_mapa.em_codigo.text
  lin  =  row
  cantidad = Integer(em_cantidad.text)
  If lin =0 Then Return

  dw_1.SetRedraw(False)
  panel            = dw_1.GetItemString(lin,"codigo")
  pesomaterial     = f_pesomaterial_prompaneles(codigo_empresa,panel)
  costematerial    = f_costematerial_prompaneles(codigo_empresa,panel)
  ventamaterial    = f_pventamaterial_prompaneles(codigo_empresa,panel)
  controles = dw_1.GetItemString(lin,"control")
  IF controles = "" Then
     linea =0
	  SELECT max(promlinmapa.linea)  
		 INTO :linea  
		 FROM  promlinmapa  
		WHERE (promlinmapa.empresa = :codigo_empresa ) AND  
				(promlinmapa.codigo  = :mapa );

  IF IsNull(linea) Then linea =0
  linea = linea +1
  INSERT INTO promlinmapa  
         ( empresa,   
           codigo,   
           linea,   
           panel,   
           observaciones,
           cantidad,
			  pesomaterial,
			  costematerial,
			  ventamaterial)  
  VALUES ( :codigo_empresa,   
           :mapa,   
           :linea,   
           :panel,   
           null,
           :cantidad,
			  :pesomaterial,
			  :costematerial,
			  :ventamaterial)  ;
COMMIT;

ELSE

  DELETE FROM promlinmapa
   WHERE (promlinmapa.empresa = :codigo_empresa)
   AND   (promlinmapa.codigo  = :mapa)
   AND   (promlinmapa.panel   = :panel )   ;
   Setnull(cantidad)
COMMIT;
END IF

  SELECT sum(promlinmapa.pesomaterial),   
         sum(promlinmapa.costematerial),   
         sum(promlinmapa.ventamaterial)  
    INTO :pesomaterial,:costematerial,   
         :ventamaterial  
    FROM   promlinmapa  
   WHERE ( promlinmapa.empresa = :codigo_empresa ) AND  
         ( promlinmapa.codigo = :mapa );
			
  UPDATE promcabmapa  
     SET pesomaterial    = :pesomaterial,   
         costematerial   = :costematerial,   
         pventamaterial  = :ventamaterial
	WHERE ( promcabmapa.empresa = :codigo_empresa ) AND  
         ( promcabmapa.codigo = :mapa );
		

COMMIT;

dw_1.SetRedraw(True)
dw_1.SetItem(dw_1.GetRow(),"promlinmapa_cantidad",cantidad)
dw_detalle.Retrieve(codigo_empresa,panel)
f_activar_campo(em_descripcion)
end event

event ue_valores;call super::ue_valores;ue_marca_linea = FALSE
end event

event clicked;call super::clicked;IF f_objeto_datawindow(This) = "marcado" Then
IF marcado = "S" Then
	marcado= "N"
ELSE
	marcado= "S"
END IF
f_control()
END IF

f_activar_campo(em_descripcion)
end event

