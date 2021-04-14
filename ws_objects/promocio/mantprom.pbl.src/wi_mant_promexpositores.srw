$PBExportHeader$wi_mant_promexpositores.srw
$PBExportComments$€ Cabecera composicion expositores
forward
global type wi_mant_promexpositores from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_promexpositores
end type
type dw_paneles from datawindow within wi_mant_promexpositores
end type
type dw_embalajes from datawindow within wi_mant_promexpositores
end type
type pb_1 from upb_salir within wi_mant_promexpositores
end type
end forward

global type wi_mant_promexpositores from wi_mvent_con_empresa
integer width = 2930
integer height = 1680
pb_calculadora pb_calculadora
dw_paneles dw_paneles
dw_embalajes dw_embalajes
pb_1 pb_1
end type
global wi_mant_promexpositores wi_mant_promexpositores

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de tipos de Muebles"
	istr_parametros.s_listado        = "report_promexpositores"
   This.title = istr_parametros.s_titulo_ventana

   dw_embalajes.SetTransObject(Sqlca)
   dw_paneles.SetTransObject(Sqlca)
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       This.TriggerEvent("ue_recuperar")
       Return  
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
tabla         = "promexpositores"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
dw_embalajes.Retrieve(codigo_empresa,sle_valor.Text)
dw_paneles.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
dw_embalajes.enabled = FALSE
dw_paneles.enabled = FALSE
end on

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
	dw_1.setitem(dw_1.getrow(),"completo","S")
	dw_1.setitem(dw_1.getrow(),"paneles","N")	
   dw_1.setitem(dw_1.getrow(),"falta",DateTime(Today()))
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
dw_embalajes.enabled = TRUE
dw_paneles.enabled = TRUE
end on

on wi_mant_promexpositores.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dw_paneles=create dw_paneles
this.dw_embalajes=create dw_embalajes
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dw_paneles
this.Control[iCurrent+3]=this.dw_embalajes
this.Control[iCurrent+4]=this.pb_1
end on

on wi_mant_promexpositores.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dw_paneles)
destroy(this.dw_embalajes)
destroy(this.pb_1)
end on

event ue_borra_fila;call super::ue_borra_fila;  DELETE FROM promlinexpositores  
   WHERE ( promlinexpositores.empresa = :codigo_empresa ) AND  
         ( promlinexpositores.codigo = :sle_valor.text)   ;
  DELETE FROM promembexpositores  
   WHERE ( promembexpositores.empresa = :codigo_empresa ) AND  
         ( promembexpositores.codigo = :sle_valor.text )   ;

COMMIT;
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_promexpositores
integer x = 14
integer y = 268
integer width = 2354
integer height = 744
string dataobject = "dw_promexpositores"
end type

event dw_1::rbuttondown; bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "proveedor"
      bus_titulo     = "VENTANA SELECCION DE PROVEEDORES"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_proveedores"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
 

end event

event dw_1::key;bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "proveedor"
      bus_titulo     = "VENTANA SELECCION DE PROVEEDORES"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_proveedores"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::key
end event

on dw_1::valores_numericos;call wi_mvent_con_empresa`dw_1::valores_numericos;f_valores_numericos(dw_1,"proveedor")
end on

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_promexpositores
integer y = 172
integer width = 448
string text = "Tipo Mueble:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_promexpositores
integer x = 2391
end type

event cb_insertar::clicked;long cuantos,registros
string v_expositor,v_descripcion,v_resumido,panel_nuevo,v_mueble
datetime v_falta
if this.enabled then
	if dw_1.object.paneles[dw_1.getrow()] = "N"  then
		//Comprobamos que tenga creado el panel automatico
		v_mueble = dw_1.object.codigo[dw_1.getrow()]
		select count(*) into :cuantos
		from promlinexpositores
		where empresa = :codigo_empresa
		and codigo = :v_mueble;
		
		if isnull(cuantos) then cuantos = 0
		if cuantos = 0  then
			messagebox("Creamos el panel","Y lo asignamos")
			//Creamos el panel	
		 
			Select count(*) Into :registros From prompaneles
			Where  prompaneles.empresa = :codigo_empresa;
			IF registros=0  Then
				 panel_nuevo = "1"
			ELSE
				 Select max(convert(int,prompaneles.codigo)+1)
				 Into   :panel_nuevo
				 From   prompaneles
				 Where  prompaneles.empresa = :codigo_empresa;
			END IF	
	
			v_falta = dw_1.object.falta[dw_1.getrow()]
			v_descripcion = dw_1.object.descripcion[dw_1.getrow()]
			v_resumido = dw_1.object.resumido[dw_1.getrow()]
			
			insert into prompaneles
			(empresa,codigo,panelmano,expositor,falta,usuario,
			descripcion,resumido,observaciones,pesomaterial,
			costematerial,grupo,peso,coste,largo,ancho,
			pventamaterial,pventa,tipo_panel,costemanipulacion,
			medida,activo)
			values
			(:codigo_empresa,:panel_nuevo,"N",:v_mueble,:v_falta,:nombre_usuario,
			:v_descripcion,:v_resumido,"",0,
			0,"0",0,0,0,0,
			0,0,"0",0,
			"0","S");
			if sqlca.sqlcode <> 0 then
				messagebox("Atención","Error al crear panel automaticamente")
				rollback;
			else
				//Lo asignamos
				insert into promlinexpositores
				(empresa,codigo,tipo,
				cantidad,medida,observaciones,panel_asignado)
				values
				(:codigo_empresa,:v_mueble,"0",
				1,"0","",:panel_nuevo);
				if sqlca.sqlcode <> 0 then
					messagebox("Atención","Error al asigar panel automaticamente")
					rollback;
				else
					commit;
				end if
				
			end if
			
		end if
	end if
end if
call super::clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_promexpositores
integer x = 2391
integer y = 408
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_promexpositores
integer x = 539
integer y = 160
integer height = 92
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_promexpositores"
ue_titulo     =  "AYUDA SELECCION EXPOSITORES"
ue_filtro     =  ""
isle_campo    = This

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
dw_embalajes.Retrieve(codigo_empresa,sle_valor.Text)
dw_paneles.Retrieve(codigo_empresa,sle_valor.Text)
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_promexpositores
integer x = 2391
integer y = 528
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_promexpositores
integer taborder = 40
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_promexpositores
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_promexpositores
integer width = 2592
end type

type pb_calculadora from u_calculadora within wi_mant_promexpositores
integer x = 805
integer y = 160
integer taborder = 0
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From promexpositores
 Where  promexpositores.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,promexpositores.codigo)+1)
  Into   :sle_valor.text
  From   promexpositores
  Where  promexpositores.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end on

type dw_paneles from datawindow within wi_mant_promexpositores
integer x = 14
integer y = 1016
integer width = 1335
integer height = 420
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle Paneles"
string dataobject = "dw_promlinexpositores3"
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

   CASE 'pb_paneles'
		if dw_1.object.paneles[dw_1.getrow()] = "S" then
			lstr_param.s_argumentos[1]  = "wi_mant_promexpositores"
         lstr_param.s_argumentos[2]  = sle_valor.Text
	      lstr_param.i_nargumentos    = 2
         OpenWithParm(wi_mant_promlinexpositores, lstr_param)
		else
			messagebox("Atención","Opción no valida si el mueble no tiene paneles")
		end if
	case else
		   if row=0 then Return
			lstr_param.s_argumentos[2]  = sle_valor.Text
	      lstr_param.s_argumentos[3]  = dw_paneles.GetItemString(row,"tipo")
			lstr_param.i_nargumentos    = 3
         OpenWithParm(wi_mant_promlinexpositores, lstr_param)
END CHOOSE

end event

type dw_embalajes from datawindow within wi_mant_promexpositores
integer x = 1349
integer y = 1016
integer width = 1522
integer height = 420
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle embalajes"
string dataobject = "dw_promexpositores3"
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

   CASE 'pb_embalajes'
			lstr_param.s_argumentos[1]  = "wi_mant_promexpositores"
         lstr_param.s_argumentos[2]  = sle_valor.Text
	      lstr_param.i_nargumentos    = 2
        OpenWithParm(wi_mant_promembexpositores, lstr_param)
END CHOOSE

end event

type pb_1 from upb_salir within wi_mant_promexpositores
integer x = 2738
integer y = 36
integer width = 128
integer height = 108
integer taborder = 0
end type

