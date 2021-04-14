$PBExportHeader$wi_mant_promembexpositores.srw
forward
global type wi_mant_promembexpositores from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_promembexpositores
end type
type dw_paneles from datawindow within wi_mant_promembexpositores
end type
type uo_expositor from u_em_campo_2 within wi_mant_promembexpositores
end type
type st_3 from statictext within wi_mant_promembexpositores
end type
type pb_1 from upb_salir within wi_mant_promembexpositores
end type
end forward

global type wi_mant_promembexpositores from wi_mvent_con_empresa
integer width = 2693
integer height = 1476
pb_calculadora pb_calculadora
dw_paneles dw_paneles
uo_expositor uo_expositor
st_3 st_3
pb_1 pb_1
end type
global wi_mant_promembexpositores wi_mant_promembexpositores

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

forward prototypes
public subroutine f_cubicolinea ()
public subroutine f_actualiza_cubico ()
end prototypes

public subroutine f_cubicolinea ();Dec{2} cubico,largo,alto,ancho
If dw_1.GetRow() = 0 Then Return
dw_1.Accepttext()
largo  = dw_1.getItemNumber(dw_1.GetRow(),"largo")
alto   = dw_1.getItemNumber(dw_1.GetRow(),"alto")
ancho  = dw_1.getItemNumber(dw_1.GetRow(),"ancho")
cubico = largo * alto * ancho
dw_1.SetItem(dw_1.GetRow(),"metros",cubico)
end subroutine

public subroutine f_actualiza_cubico ();Dec{2} cubico,peso
String expositor
expositor =  uo_expositor.em_codigo.text

Select sum(metros),sum(peso) Into :cubico,:peso From promembexpositores
Where  promembexpositores.empresa = :codigo_empresa
And    promembexpositores.codigo  = :expositor;

UPDATE promexpositores  
SET peso_embalaje  = :peso,   
    metros_cubicos = :cubico  
WHERE (promexpositores.empresa = :codigo_empresa ) AND  
      (promexpositores.codigo  = :expositor )   ;
COMMIT;

end subroutine

on open;call wi_mvent_con_empresa::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de embajes por expositor"
	istr_parametros.s_listado        = "report_promembexpositores"
   This.title = istr_parametros.s_titulo_ventana
   dw_paneles.SetTransObject(Sqlca)
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      uo_expositor.em_codigo.text=istr_parametros.s_argumentos[2]
      uo_expositor.em_campo.text= f_nombre_promexpositores(codigo_empresa,uo_expositor.em_codigo.text)
      dw_paneles.Retrieve(codigo_empresa,uo_expositor.em_codigo.text)
   END IF
   

	
end on

on ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(uo_expositor.em_codigo.text))
criterio[2]   =  trim(uo_expositor.em_codigo.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "promexpositores"

dw_1.Retrieve(codigo_empresa,uo_expositor.em_codigo.text,Integer(sle_valor.Text))
dw_paneles.Retrieve(codigo_empresa,uo_expositor.em_codigo.text)


CALL Super::ue_recuperar
end on

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",uo_expositor.em_codigo.text)
   dw_1.setitem(dw_1.getrow(),"linea",Integer(sle_valor.text))
  
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
dw_paneles.enabled = FALSE
uo_expositor.enabled = FALSE
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
dw_paneles.enabled = TRUE
uo_expositor.enabled = TRUE
end on

on wi_mant_promembexpositores.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dw_paneles=create dw_paneles
this.uo_expositor=create uo_expositor
this.st_3=create st_3
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dw_paneles
this.Control[iCurrent+3]=this.uo_expositor
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.pb_1
end on

on wi_mant_promembexpositores.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dw_paneles)
destroy(this.uo_expositor)
destroy(this.st_3)
destroy(this.pb_1)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_promembexpositores
integer x = 18
integer y = 292
integer width = 2139
integer height = 380
string dataobject = "dw_promembexpositores"
end type

on dw_1::itemchanged;call wi_mvent_con_empresa`dw_1::itemchanged;f_cubicolinea()
end on

on dw_1::key;call wi_mvent_con_empresa`dw_1::key;f_cubicolinea()

end on

on dw_1::clicked;call wi_mvent_con_empresa`dw_1::clicked;f_cubicolinea()
end on

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_promembexpositores
integer x = 1335
integer y = 180
integer width = 242
string text = "Linea:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_promembexpositores
integer x = 2185
integer y = 284
end type

on cb_insertar::clicked;call wi_mvent_con_empresa`cb_insertar::clicked;f_actualiza_cubico()
end on

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_promembexpositores
integer x = 2185
integer y = 404
end type

on cb_borrar::clicked;call wi_mvent_con_empresa`cb_borrar::clicked;f_actualiza_cubico()
end on

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_promembexpositores
integer x = 1591
integer y = 176
integer taborder = 20
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;IF Trim(uo_expositor.em_campo.text) = "" Then f_activar_campo(uo_expositor.em_campo)
ue_datawindow =  "dw_ayuda_promexpositores"
ue_titulo     =  "AYUDA SELECCION EXPOSITORES"
ue_filtro     =  ""
isle_campo    = This
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_promembexpositores
integer x = 2185
integer y = 524
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_promembexpositores
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_promembexpositores
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_promembexpositores
integer width = 2441
end type

type pb_calculadora from u_calculadora within wi_mant_promembexpositores
integer x = 1856
integer y = 168
integer taborder = 0
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
String expositor
  expositor =  uo_expositor.em_codigo.text
 Select count(*) Into :registros From promembexpositores
 Where  promembexpositores.empresa = :codigo_empresa
 And    promembexpositores.codigo = :expositor;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,promembexpositores.linea)+1)
  Into   :sle_valor.text
  From   promembexpositores
  Where  promembexpositores.empresa = :codigo_empresa
  And    promembexpositores.codigo = :expositor;
 END IF
 dw_1.TriggerEvent("Clicked")
end on

type dw_paneles from datawindow within wi_mant_promembexpositores
integer x = 14
integer y = 672
integer width = 2149
integer height = 536
boolean bringtotop = true
string dataobject = "dw_promembexpositores2"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF Row =0 Then 
 f_activar_campo(uo_expositor.em_campo)
 Return
END IF

sle_valor.text = String(This.GetItemNumber(Row,"linea"))
Parent.TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)
end event

type uo_expositor from u_em_campo_2 within wi_mant_promembexpositores
integer x = 439
integer y = 168
integer width = 873
integer height = 96
integer taborder = 10
end type

on modificado;call u_em_campo_2::modificado;uo_expositor.em_campo.text=f_nombre_promexpositores(codigo_empresa,uo_expositor.em_codigo.text)
IF Trim(uo_expositor.em_campo.text)="" THEN 
 IF Trim(uo_expositor.em_codigo.text)<>"" Then uo_expositor.em_campo.SetFocus()
 uo_expositor.em_campo.text=""
 uo_expositor.em_codigo.text=""
END IF
dw_paneles.Retrieve(codigo_empresa,uo_expositor.em_codigo.text)
 
end on

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de expositores"
ue_datawindow = "dw_ayuda_promexpositores"
ue_filtro     = ""
end on

on uo_expositor.destroy
call u_em_campo_2::destroy
end on

type st_3 from statictext within wi_mant_promembexpositores
integer x = 133
integer y = 180
integer width = 302
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
string text = "Expositor:"
alignment alignment = right!
boolean focusrectangle = false
end type

type pb_1 from upb_salir within wi_mant_promembexpositores
integer x = 2491
integer y = 32
integer width = 128
integer height = 116
integer taborder = 0
end type

