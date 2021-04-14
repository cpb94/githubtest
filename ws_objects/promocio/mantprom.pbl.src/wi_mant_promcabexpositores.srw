$PBExportHeader$wi_mant_promcabexpositores.srw
forward
global type wi_mant_promcabexpositores from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_promcabexpositores
end type
type dw_paneles from datawindow within wi_mant_promcabexpositores
end type
type pb_1 from upb_salir within wi_mant_promcabexpositores
end type
type gb_1 from groupbox within wi_mant_promcabexpositores
end type
type dw_detalle1 from datawindow within wi_mant_promcabexpositores
end type
end forward

global type wi_mant_promcabexpositores from wi_mvent_con_empresa
integer width = 2958
integer height = 1664
pb_calculadora pb_calculadora
dw_paneles dw_paneles
pb_1 pb_1
gb_1 gb_1
dw_detalle1 dw_detalle1
end type
global wi_mant_promcabexpositores wi_mant_promcabexpositores

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de expositores"
istr_parametros.s_listado        = "report_prompanexpositores"
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

event ue_borra_fila;call super::ue_borra_fila;String expositor
expositor = sle_valor.text

   DELETE FROM prompanexpositores  
   WHERE ( prompanexpositores.empresa = :codigo_empresa ) AND  
         ( prompanexpositores.codigo = :sle_valor.text );
COMMIT;
end event

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "promcabexpositores"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

dw_paneles.Retrieve(codigo_empresa,sle_valor.Text)
dw_detalle1.Retrieve(codigo_empresa,"")

CALL Super::ue_recuperar
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
dw_paneles.enabled = TRUE
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
dw_paneles.enabled = FALSE
end on

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"falta",DateTime(Today()))
end event

on wi_mant_promcabexpositores.create
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

on wi_mant_promcabexpositores.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dw_paneles)
destroy(this.pb_1)
destroy(this.gb_1)
destroy(this.dw_detalle1)
end on

event ue_actualiza_dw;call super::ue_actualiza_dw;dec    pesomaterial,costematerial,ventamaterial,pesopanel,costepanel,ventapanel,coste_manipulacion
string expositor,v_mueble,v_panel ,v_tipo
long   cuantos

expositor = sle_valor.text

 if dw_1.object.paneles[dw_1.getrow()] = "N" then
	 SELECT count(*)  
	 INTO :cuantos  
	 FROM  prompanexpositores  
	 WHERE (prompanexpositores.empresa = :codigo_empresa ) AND  
			(prompanexpositores.codigo = :sle_valor.text);
	
	 IF IsNull(cuantos) Then cuantos =0
	 if cuantos = 0 then
		v_mueble = dw_1.object.tipo[dw_1.getrow()] 
		
		select max(panel_asignado),max(tipo) into :v_panel,:v_tipo
		from promlinexpositores 
		where empresa = :codigo_empresa
		and codigo = :v_mueble;
		if sqlca.sqlcode = 0 then
			 INSERT INTO prompanexpositores 
					(empresa,codigo,linea,panel,observaciones,pesomaterial,
					costematerial,ventamaterial,tipo,pesopanel,costepanel,ventapanel,coste_manipulacion)  
			  VALUES (:codigo_empresa,:sle_valor.text,1,:v_panel,null,0,0,0,:v_tipo,0,0,0,0);
			  if sqlca.sqlcode = 0 then
				  commit;
				else
					messagebox("Atención","Error al asignar panel automaticamente")
					rollback;
				end if
		else
			messagebox("Atención","Mueble sin paneles mal generado")
		end if
	 end if
end if

SELECT  sum(pesomaterial),sum(costematerial),sum(ventamaterial),
	     sum(pesopanel),sum(costepanel),sum(ventapanel),
	     sum(coste_manipulacion)
INTO    :pesomaterial,:costematerial,:ventamaterial,
	     :pesopanel,:costepanel,:ventapanel,:coste_manipulacion
FROM    prompanexpositores  
WHERE   (prompanexpositores.empresa = :codigo_empresa )
AND     (prompanexpositores.codigo = :expositor);

UPDATE promcabexpositores  
SET pesomaterial       = :pesomaterial,   
	 costematerial      = :costematerial,   
	 pventamaterial     = :ventamaterial,
	 pesopanel          = :pesopanel,
	 costepanel         = :costepanel,
	 ventapanel         = :ventapanel,
	 coste_manipulacion = :coste_manipulacion
WHERE ( promcabexpositores.empresa = :codigo_empresa ) AND  
	   ( promcabexpositores.codigo = :expositor )   ;

if sqlca.sqlcode <> 0 then
	rollback;
else
	commit;
end if
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_promcabexpositores
integer x = 18
integer y = 268
integer width = 2853
integer height = 576
string dataobject = "dw_promcabexpositores"
end type

event dw_1::valores_numericos;//f_valores_numericos(dw_1,"tipo")
end event

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

event itemchanged;string tipo_mueble,var_paneles

CHOOSE CASE GetColumnName()
   
   CASE "tipo"
       
		this.AcceptText()
		tipo_mueble  = this.object.tipo[This.GetRow()]
  
      SELECT paneles into :var_paneles
		from promexpositores 
		where empresa = :codigo_empresa
		and codigo = :tipo_mueble;
		
		this.object.paneles[this.getrow()] = var_paneles
		this.AcceptText()
end choose
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_promcabexpositores
integer x = 123
integer y = 172
integer width = 325
string text = "Expositor:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_promcabexpositores
integer x = 1623
integer y = 172
integer height = 76
end type

event cb_insertar::clicked;
call super::clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_promcabexpositores
integer x = 2030
integer y = 172
integer height = 76
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_promcabexpositores
integer x = 471
integer y = 160
integer height = 92
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_promcabexpositores"
ue_titulo     =  "AYUDA SELECCION EXPOSITORES"
ue_filtro     =  ""
isle_campo    = This

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
dw_paneles.Retrieve(codigo_empresa,sle_valor.Text)
//dw_detalle1.Retrieve(codigo_empresa,"")

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_promcabexpositores
integer x = 2437
integer y = 172
integer height = 76
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_promcabexpositores
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_promcabexpositores
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_promcabexpositores
integer width = 2592
end type

type pb_calculadora from u_calculadora within wi_mant_promcabexpositores
integer x = 731
integer y = 160
integer taborder = 0
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From promcabexpositores
 Where  promcabexpositores.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,promcabexpositores.codigo)+1)
  Into   :sle_valor.text
  From   promcabexpositores
  Where  promcabexpositores.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end on

type dw_paneles from datawindow within wi_mant_promcabexpositores
integer x = 9
integer y = 844
integer width = 1339
integer height = 584
boolean bringtotop = true
boolean titlebar = true
string title = "Paneles del Expositor"
string dataobject = "dw_promcabexpositores2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;string ls_objeto
str_parametros lstr_param

// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow
// Santiago 14/09/00
//if dw_1.object.paneles[dw_1.getrow()] <> "N" then
		
	ls_objeto = This.GetObjectAtPointer()
	
	ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)
	
	CHOOSE CASE ls_objeto
		CASE 'pb_carpeta'
				lstr_param.s_argumentos[1]  = "w_int_promcabexpositores"
				lstr_param.s_argumentos[2]  = sle_valor.Text
				lstr_param.i_nargumentos    = 2
				OpenWithParm(w_int_prompanexpositores, lstr_param)
		CASE ELSE
				If row=0 Then Return
				This.SelectRow(0,FALSE)
				This.SelectRow(row,TRUE)
				dw_detalle1.Retrieve(codigo_empresa,GetItemString(row,"panel"))
	END CHOOSE
//ELSE
//	MESSAGEBOX("Atención","Solo para expositores con paneles")
//end if
	

end event

event rbuttondown;If row=0 Then Return
This.SelectRow(0,FALSE)
This.SelectRow(row,TRUE)
end event

event retrieveend;if this.rowcount() > 0 then
	this.selectrow(1,true)	
	this.setrow(1)	
	dw_detalle1.Retrieve(codigo_empresa,this.object.panel[this.getrow()])
end if
end event

type pb_1 from upb_salir within wi_mant_promcabexpositores
integer x = 2720
integer y = 28
integer width = 128
integer height = 104
integer taborder = 0
end type

type gb_1 from groupbox within wi_mant_promcabexpositores
integer x = 1614
integer y = 136
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

type dw_detalle1 from datawindow within wi_mant_promcabexpositores
integer x = 1349
integer y = 844
integer width = 1518
integer height = 584
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle de los paneles"
string dataobject = "dw_promcabexpositores3"
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
		if dw_paneles.rowcount() > 0 then
			if dw_paneles.getrow() > 0 then
				lstr_param.s_argumentos[1]  = "w_int_promcabexpositores"
				lstr_param.s_argumentos[2]  = dw_paneles.object.panel[dw_paneles.getrow()]
				lstr_param.i_nargumentos    = 2
				OpenWithParm(wi_mant_prommapapaneles, lstr_param)
			else
				if dw_paneles.rowcount() = 1 then
					dw_paneles.selectrow(0,false)
					dw_paneles.selectrow(1,true)	
					dw_paneles.setrow(1)	
					lstr_param.s_argumentos[1]  = "w_int_promcabexpositores"
					lstr_param.s_argumentos[2]  = dw_paneles.object.panel[dw_paneles.getrow()]
					lstr_param.i_nargumentos    = 2
					OpenWithParm(wi_mant_prommapapaneles, lstr_param)					
				end if
			end if
		end if
	case else
		if dw_paneles.rowcount() > 0 then
			this.Retrieve(codigo_empresa,dw_paneles.object.panel[dw_paneles.getrow()])
		end if
end choose
end event

