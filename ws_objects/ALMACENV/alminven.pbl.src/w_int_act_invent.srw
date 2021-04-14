$PBExportHeader$w_int_act_invent.srw
$PBExportComments$Actualizacion de inventario.
forward
global type w_int_act_invent from w_int_con_empresa
end type
type st_2 from statictext within w_int_act_invent
end type
type em_periodo from u_em_campo within w_int_act_invent
end type
type dw_1 from datawindow within w_int_act_invent
end type
type cb_2 from u_boton within w_int_act_invent
end type
type pb_1 from upb_salir within w_int_act_invent
end type
end forward

global type w_int_act_invent from w_int_con_empresa
integer width = 2903
integer height = 1652
st_2 st_2
em_periodo em_periodo
dw_1 dw_1
cb_2 cb_2
pb_1 pb_1
end type
global w_int_act_invent w_int_act_invent

type variables
String    sel,almacen,zona,referencia
string   tipo_pallet,articulo,calidad,tono,caja
DataStore data
Dec       x1,x2,fila,altura,calibre
Dec {2} fisico,contable,diferencia
DateTime  fecha
end variables

forward prototypes
public function boolean f_entrada ()
public function boolean f_control_reservas ()
end prototypes

public function boolean f_entrada ();str_almlinubicahis ubihis
str_almmovhis      mov
str_almlinubica    ubi
Dec contador_nummov,contador_orden 
Dec bien
 ubihis.usuario       = nombre_usuario
 mov.usuario          = nombre_usuario
 ubihis.empresa       = codigo_empresa
 ubihis.anyo          = year(Date(fecha))
 ubihis.almacen       = almacen
 ubihis.articulo      = articulo
 ubihis.calidad       = calidad
 ubihis.tonochar      = tono
 ubihis.calibre       = calibre
 IF IsNUll(ubihis.calibre) Then ubihis.calibre = 0
 IF IsNUll(ubihis.tonochar)    Then ubihis.tonochar = ""
 ubihis.fecha         = fecha
 ubihis.f_alta        = DateTime(Today(),now())
SetNull( ubihis.observaciones)
 ubihis.tipomov       = "215"
 ubihis.tipo_pallet   = tipo_pallet
 ubihis.caja          = caja
  SELECT articulos.familia,articulos.formato,articulos.modelo,
  			articulos.unidad,articulos.sector
    INTO :ubihis.familia,:ubihis.formato,   
         :ubihis.modelo,:ubihis.tipo_unidad  ,:ubihis.sector
    FROM articulos  
   WHERE articulos.empresa= :ubihis.empresa
	AND   articulos.codigo = :ubihis.articulo ;
IF SQLCA.SQLCode<>0 THEN bien=1
 ubihis.referencia   = f_componer_ref(ubihis.articulo,&
                                      ubihis.calidad,&
                                      ubihis.tonochar,ubihis.calibre)

ubi.empresa    =  ubihis.empresa
ubi.almacen    =  ubihis.almacen
ubi.articulo   =  ubihis.articulo
ubi.familia    =  ubihis.familia
ubi.formato    =  ubihis.formato
ubi.modelo     =  ubihis.modelo
ubi.calidad    =  ubihis.calidad
ubi.tonochar   =  ubihis.tonochar
ubi.calibre    =  ubihis.calibre
ubi.tipo_pallet=  ubihis.tipo_pallet
ubi.caja       =  ubihis.caja
ubi.sector     =  ubihis.sector
SetNull(ubi.anyo)
SetNull(ubi.pedido) 
SetNull(ubi.linped)
SetNull(ubi.cliente)
ubi.tipo_unidad=  ubihis.tipo_unidad
ubi.referencia =  ubihis.referencia
ubi.f_alta     =  Datetime(today(),now())
// Valor movimiento historico
mov.empresa    =  ubihis.empresa
mov.almacen    =  ubihis.almacen
mov.articulo   =  ubihis.articulo
mov.familia    =  ubihis.familia
mov.formato    =  ubihis.formato
mov.modelo     =  ubihis.modelo
mov.calidad    =  ubihis.calidad
mov.tonochar   =  ubihis.tonochar
mov.calibre    =  ubihis.calibre
mov.tipo_unidad=  ubihis.tipo_unidad
mov.tipo_pallet=  ubihis.tipo_pallet
mov.caja       =  ubihis.caja
mov.sector     =  ubihis.sector
mov.referencia =  ubihis.referencia
ubi.referencia = mov.referencia
mov.f_alta     =  DateTime(Today(),now())
mov.anyo       =  year(Date(fecha))
mov.origen     = "11"
mov.fechmov    = ubihis.fecha
mov.tipomov    = ubihis.tipomov
mov.cantidade  = diferencia
mov.cantidads  =0
mov.precio     =0
SetNull(mov.codtercero)
mov.numdoc        = Mid(STring(Year(Date(fecha))),3,2) + "-" +STring(Month(Date(fecha)))
mov.situacion     = "N"
SetNull(mov.observaciones)
SetNull(mov.punteado)
mov.antexist   =0
// Variable utilizada para montaje observaciones en lineas de ubicacion
  String var_observaciones
//-------------------------------------------------------------------
  contador_nummov= f_almparam_nummov(codigo_empresa,Year(Date(fecha)))
  contador_orden = f_almparam_numorden(codigo_empresa,Year(Date(fecha)))
  mov.nummov     = contador_nummov
  ubihis.nummov  = contador_nummov
  ubihis.orden   = contador_orden
     ubihis.zona       = zona
     ubihis.fila       = fila
     ubihis.altura     = altura
	  IF IsNull(ubihis.altura) Then ubihis.altura = 0
     ubihis.cantidade  = diferencia
     ubihis.orden      = contador_orden
     ubihis.nummov     = contador_nummov
     ubihis.observaciones  = mov.observaciones
     ubihis.f_alta     = DateTime(Today(),now())
     ubihis.usuario    = nombre_usuario
     ubihis.ubicacion  = f_componer_ubicacion(ubihis.almacen,ubihis.zona,&
                                              ubihis.fila,ubihis.altura)
     ubihis.cantidads    = 0
     ubi.zona            = ubihis.zona
     ubi.fila            = ubihis.fila
     ubi.altura          = ubihis.altura
     ubi.existencias     = ubihis.cantidade
     ubi.ubicacion       = ubihis.ubicacion
     //------------------------------------------------------------------
     // Inserto en el historico de lineas de ubicacion por movimiento
     //------------------------------------------------------------------
     IF Not f_insert_almlinubicahis(ubihis) Then  bien=1
	  
    
//-----------------------------------------------------------------------
// Variables para cargar el cursor
//-----------------------------------------------------------------------
      String cur_empresa,cur_almacen
      dec cur_pedido,cur_linea,cur_anyo
      decimal{4}  cur_existencias
      string  cur_referencia,cur_ubicacion,cur_tipo_pallet
     
//----------------------------------------------------------
// Busco si hay linea este articulo sin reservar
//---------------------------------------------------------
dec registros
DataStore dw_proceso 
Sel = " SELECT   linea,existencias  " + &
      " FROM     almlinubica  " + &
      " WHERE    almlinubica.empresa    = '"+ codigo_empresa  + "'" +&
		" AND      almlinubica.ubicacion  = '"+ ubi.ubicacion + "'" +&
		" AND      almlinubica.referencia = '"+ ubi.referencia + "'" + &
		" AND      almlinubica.tipo_pallet= '"+ ubihis.tipo_pallet + "'" + &
		" AND      almlinubica.caja       = '"+ ubihis.caja + "'" + &
		" AND      almlinubica.pedido is null "

//dw_proceso = f_cargar_cursor2(sel)
f_cargar_cursor_nuevo(sel, dw_proceso)


registros = dw_proceso.RowCount()
dec grabado,salir
grabado=0
salir  =0
IF registros<>0 THEN
 FOR x1 = 1 To registros
  cur_empresa       =   codigo_empresa
  cur_almacen       =   f_almacen_ubicacion(ubi.ubicacion)
  cur_ubicacion     =   ubi.ubicacion
  cur_referencia    =   ubi.referencia
  cur_existencias   =   dw_proceso.GetItemNumber(x1,"existencias")
  cur_tipo_pallet   =   ubihis.tipo_pallet
  cur_linea         =   dw_proceso.GetItemNumber(x1,"linea")
  grabado = 1
     ubi.existencias=ubi.existencias + cur_existencias
       UPDATE almlinubica  
       SET existencias   = :ubi.existencias,   
       f_alta            = :ubi.f_alta
       WHERE  almlinubica.empresa   = :ubi.empresa 
		 AND    almlinubica.ubicacion = :ubi.ubicacion 
		 AND    almlinubica.linea     = :cur_linea  USING SQLCA;
       IF SQLCA.SQLCode<>0 THEN  bien=1
       EXIT
NEXT
END IF
IF grabado=0 THEN
    cur_linea=0
   SELECT  max(almlinubica.linea)  INTO :cur_linea FROM almlinubica  
   WHERE   almlinubica.empresa   = :ubi.empresa 
	AND     almlinubica.ubicacion = :ubi.ubicacion;
   IF IsNull(cur_linea) or trim(string(cur_linea))="" THEN
    cur_linea = 0 
   END IF
    cur_linea=cur_linea+1
    ubi.linea=cur_linea
    SetNull(ubi.observaciones)
   IF NOT f_insert_almlinubica(ubi) Then  bien=1

END IF
//-----------------------Fin Grabación Lineas de Ubicacion--------------
// el contador incrementa uno para cada linea
     contador_orden = contador_orden + 1

 // Grabar el movimiento en el historico por el total de existencias
   IF NOT f_insert_almmovhis(mov) Then
      MessageBox("Error en proceso","Grabando almmovhis",Exclamation!, OK!,1)
      bien=1
   END IF
   IF NOT f_actualiza_nummov(mov.empresa,Year(Date(fecha)),mov.nummov) THEN
      bien=1
   END IF
	 IF NOT f_actualiza_numorden(ubihis.empresa,Year(Date(fecha)),ubihis.orden) THEN
      bien=1
   END IF

  destroy dw_proceso

  CHOOSE CASE bien
	CASE 1
		Return FALSE
	CASE 0
      Return TRUE
   CASE ELSE
      Return FALSE
  END CHOOSE
end function

public function boolean f_control_reservas ();//DataStore d
//Dec q1,tonot,calibret,r1,r
//String referenciat,tipo_pallett
//
//fecha = dw_1.GetItemDateTime(dw_1.GetRow(),"fecha_inv")
//sel = " Select referencia,tipo_pallet,sum(existencias) existencias from alminvent " +&
//		" Where empresa = '" + codigo_empresa + "'" +&
//		" And   fecha_inv = '" +STring(Date(fecha),"dd/mm/yyyy")+"'"+&
//		" And   (referencia <> referenciat or tipo_pallet <> tipo_pallett or existencias <> existenciast) " +&
//		" ANd   activo = 'S'  "+&
//		" Group By referencia,tipo_pallet"
//		
//d = f_cargar_cursor(sel)
//IF d.RowCOunt() <> 0 Then Return TRUE
//For q1 = 1 To d.RowCOunt()
//	referencia        = d.GetItemString(q1,"referencia")
//	articulo        	= f_articulo_referencia(referencia)
//	calidad        	= f_calidad_referencia(referencia)
//	tipo_pallet       = d.GetItemString(q1,"tipo_pallet")
//	fisico            = d.GetItemNumber(q1,"existencias")
//	tono          		= Dec(f_tono_referencia(referencia))
//	calibre           = Dec(f_calibre_referencia(referencia))
//	IF fisico <  f_reservado_referencia_tipo_pallet(codigo_empresa,referencia,tipo_pallet) then Return FALSE
//	f_mensaje_proceso("Control Pedidos" ,q1,d.RowCount())
//Next
Return True
end function

on open;call w_int_con_empresa::open;
istr_parametros.s_titulo_ventana="Proceso actualizacion inventarios"
This.title=istr_parametros.s_titulo_ventana
dw_1.settransobject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)		// Use hand for focus indicator
em_periodo.text=String(year(today()))
dw_1.Retrieve(codigo_empresa,Integer(em_periodo.text))




end on

on w_int_act_invent.create
int iCurrent
call super::create
this.st_2=create st_2
this.em_periodo=create em_periodo
this.dw_1=create dw_1
this.cb_2=create cb_2
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.em_periodo
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.pb_1
end on

on w_int_act_invent.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.em_periodo)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.pb_1)
end on

event activate;call super::activate;w_int_act_invent = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_act_invent
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_act_invent
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_act_invent
end type

type st_2 from statictext within w_int_act_invent
integer y = 180
integer width = 274
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Periodo"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_periodo from u_em_campo within w_int_act_invent
integer x = 325
integer y = 164
integer taborder = 10
maskdatatype maskdatatype = numericmask!
string mask = "####"
end type

on modified;call u_em_campo::modified;dw_1.Retrieve(codigo_empresa,Integer(em_periodo.text))
end on

type dw_1 from datawindow within w_int_act_invent
integer x = 585
integer y = 164
integer width = 777
integer height = 356
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_int_act_invent1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

on losefocus;This.BorderStyle=StyleRaised!
end on

on getfocus;This.BorderStyle=StyleLowered!
end on

type cb_2 from u_boton within w_int_act_invent
integer x = 1367
integer y = 164
integer width = 389
integer height = 152
integer taborder = 30
string text = "&Actualizar"
end type

event clicked;String  referenciat,ubicaciont,tipo_pallett,zonat,tonot
Int calibret,filat,alturat
Int bien=0
Dec linea,r,t1,f1
STring ubicacion
IF MessageBox("Proceso Actualizacion","¿Desea Actualizar el Inventario?",Question!,YesNo!,2) = 2 Then Return
IF Not f_control_reservas() Then 
	f_mensaje("Proceso de Actualizacion","Existen diferencias que afectan a pedidos ¡No se puede Actualizar!")
	Return
END IF


fecha = dw_1.GetItemDateTime(dw_1.GetRow(),"fecha_inv")
sel = " Select * from alminvent "+&
		" Where empresa   = '"+ codigo_empresa + "'"+&
		" And   fecha_inv = '" +STring(Date(fecha),"dd/mm/yyyy")+"'"+&
		" And   fecha_actualizado is null "+&
		" And   (referencia <> referenciat or tipo_pallet <> tipo_pallett or existencias <> existenciast or fila <> filat or altura <> alturat) " +&
		" And   activo = 'S'"
		
//data = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, data)


x2 = data.RowCount()
IF x2 = 0 Then 
	f_mensaje("Proceso Inventario ","Inventario Inexistente o actualizado")
	destroy data
	return
END IF

IF Not f_bloquear_almacen(w_int_act_invent.title) Then
For f1 = 1 To x2
	referencia  = data.GetItemSTring(f1,"referencia")
	ubicacion   = data.GetItemSTring(f1,"ubicacion")
	articulo    = data.GetItemSTring(f1,"articulo")
	calidad     = data.GetItemSTring(f1,"calidad")
	tono        = data.GetItemString(f1,"tonochar")
	linea       = data.GetItemNumber(f1,"linea")
	calibre     = data.GetItemNumber(f1,"calibre")
	tipo_pallet = data.GetItemString(f1,"tipo_pallet")
	caja        = data.GetItemString(f1,"caja")
	almacen     = data.GetItemString(f1,"almacen")
	zona        = data.GetItemString(f1,"zona")
	fila        = data.GetItemNumber(f1,"fila")
	altura      = data.GetItemNumber(f1,"altura")
	fisico      = data.GetItemNumber(f1,"existencias")
	contable    = data.GetItemNumber(f1,"existenciast")
	tipo_pallett = data.GetItemString(f1,"tipo_pallett")
	referenciat = data.GetItemString(f1,"referenciat")
	tonot = data.GetItemString(f1,"tonotchar")
	calibret = data.GetItemNumber(f1,"calibret")
	zonat = data.GetItemSTring(f1,"zonat")
	filat = data.GetItemNumber(f1,"filat")
	alturat = data.GetItemNumber(f1,"alturat")
	IF IsNull(contable) Then contable = 0
	IF IsNull(fisico) Then fisico = 0
	diferencia = fisico - contable
//	Update alminvent 
//			Set   fecha_actualizado = :fecha
//			Where empresa   = :codigo_empresa
//			And   ubicacion = :ubicacion
//			And   linea     = :linea;
//			IF sqlca.sqlcode <> 0 Then bien = 1
			
	t1 = 1
	ubicaciont = f_componer_ubicacion(almacen,zona,filat,alturat)
	IF referencia <> referenciat or fila <> filat or altura <> alturat or tipo_pallet <> tipo_pallett Then t1 = 2
	diferencia =  fisico - contable

   For r = 1 To t1			
	IF  t1 = 2 Then
		IF r = 1 Then
				fisico      = data.GetItemNumber(f1,"existencias")
				contable = 0
				diferencia = fisico - contable
		END IF
		IF r = 2 Then
				contable    = data.GetItemNumber(f1,"existenciast")
				fisico = 0
				diferencia =  fisico - contable
				tipo_pallet = tipo_pallett
				referencia = referenciat
				tono = tonot
				calibre = calibret
				zona = zonat
				fila = filat
				altura = alturat
				ubicacion  =f_componer_ubicacion(almacen,zona,fila,altura)
		END IF
	END IF

	IF diferencia <> 0 Then
			IF Not f_entrada() Then bien = 1
			IF bien = 0 Then 
				Update alminvent 
				Set   fecha_actualizado = :fecha
				Where empresa   = :codigo_empresa
				And   ubicacion = :ubicacion
				And   linea     = :linea;
				IF sqlca.sqlcode = 0 Then 
					commit;
				else
					rollback;
					f_mensaje("Fin de proceso","Errores durante actualizacion")
					f_desbloquear_almacen(w_int_act_invent.title)
					destroy data
					Return					
				end if
			ELSE
				Rollback;
				f_mensaje("Fin de proceso","Errores durante actualizacion")
				f_desbloquear_almacen(w_int_act_invent.title)
				destroy data
				Return
			END IF
	else
		Update alminvent 
		Set   fecha_actualizado = :fecha
		Where empresa   = :codigo_empresa
		And   ubicacion = :ubicacion
		And   linea     = :linea;
		IF sqlca.sqlcode = 0 Then 
			commit;
		else
			rollback;
		end if
	END IF

Next
f_mensaje_proceso("Procesando......"+String(f1)+"-"+String(x2),f1,x2)
Next

f_desbloquear_almacen(w_int_act_invent.title)
end if

destroy data

end event

type pb_1 from upb_salir within w_int_act_invent
integer x = 2706
integer y = 36
integer width = 119
integer height = 116
integer taborder = 0
boolean bringtotop = true
end type

