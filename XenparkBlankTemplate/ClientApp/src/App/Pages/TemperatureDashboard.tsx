import React,{useEffect, useState} from 'react';
import {Row, Card,Col,Container} from 'react-bootstrap';
import TemperatureCard from './TemperatureCard'
import ReactSpeedometer from 'react-d3-speedometer'
const TempratureDashboard = () =>{

    const[currentTemp, setCurrentTemp] = useState(0)
    const [status,setStatus] = useState('')
    const [badgeColor, setBadgeColor] = useState('yellow')
    const [fontColor,setFontColor] = useState('white')
    useEffect(()=>{

      //generating temp. value randomly
      setInterval(()=>{
        let temp = Math.floor( Math.random() * (80 - 20));
        setCurrentTemp(temp)
      },8000)

      // for badge
      if(currentTemp <= 20){
        setStatus('Low')
        setBadgeColor('yellow')
        setFontColor('black')
      }else if (currentTemp>20 && currentTemp<=80){
        setStatus('Moderate')
        setBadgeColor('green')
        setFontColor('white')
      }
      else{
        setStatus('High')
        setBadgeColor('red')
        setFontColor('white')
      }
    },[currentTemp])

 
    
    return(
        <div style={{marginTop: '100px'}}>
        <Container>
          <Card> 
            <Card.Header> 
            <Row>
            <span style = {{fontSize: '20px', display: 'block', margin: '0 auto', fontWeight: 'bold'}}>Room #1001</span>
          </Row>
          <Row>
            <span style = {{fontSize: '20px', display: 'block', margin: '0 auto', fontWeight: 'bold'}}>Description: Granulation Room - AD-Zone</span>
          </Row>
          </Card.Header>
          <Row style = {{marginLeft: '40px', marginBottom: '38px', marginTop: '30px'}}>
            <Col>
              <span style = {{fontSize: '20px', fontWeight: 'bold', display: 'block'}}> Batch: #373733 </span>
            </Col>
            <Col>
              <span style = {{fontSize: '20px', fontWeight: 'bold', display: 'block'}}> Product Code: MoviPre</span>
            </Col>
            <Col>
              <span style = {{fontSize: '20px', fontWeight: 'bold', marginLeft: '2px !important'}}> Description: Granulation Room </span>
            </Col>
          </Row>
            
            <Row>
               <Col >
               <Card style = {{maxWidth: '370px', marginLeft: '100px', marginRight: '50px'}}>
                <Card.Header style ={{ fontSize: '20px', fontWeight: 'bold'}}>Room Temperature</Card.Header>
                    <Card.Body>
                        <span style = {{display:'flex', height: '170px', flexDirection: 'column', alignItems: 'center', gap: '10px'}}>
                           <ReactSpeedometer 
                             needleTransitionDuration={4000}
                             //@ts-ignore
                             needleTransition= 'easeElastic'
                             needleColor='black'
                             segments= {3}
                             segmentColors ={['yellow','green','green','red']}
                             customSegmentStops ={[18,30,50,80,100]}
                             currentValueText = {'30'}
                             minValue={18}
                             maxValue ={100}
                             value = {30}
                             textColor ={'black'}
                             width= {200}
                             height = {125}
                             />
                            <span style = {{backgroundColor: `green`, width: '82px', borderRadius: '7px',textAlign: 'center', color: `white`}}>Moderate</span>
                        </span>
                        <span style ={{fontSize: '20px', fontWeight: 'bolder', display:'block', textAlign: 'center', marginBottom: '20px'}}>Temperature 30&deg;c</span>
                        <span style ={{fontSize: '20px', fontWeight: 'bolder'}}>Low  {20}&deg;c</span>
                        <span style ={{marginLeft: '150px',fontSize: '20px', fontWeight: 'bolder'}}>High {80}&deg;c</span>
                    </Card.Body>

            </Card>
               </Col>
               <Col>
               <Card style = {{maxWidth: '370px', marginLeft: '100px', marginRight: '50px'}}>
                <Card.Header style ={{ fontSize: '20px', fontWeight: 'bold'}}>Room Humidity</Card.Header>
                    <Card.Body>
                        <span style = {{display:'flex', height: '170px', flexDirection: 'column', alignItems: 'center', gap: '10px'}}>
                           <ReactSpeedometer 
                             needleTransitionDuration={4000}
                             //@ts-ignore
                             needleTransition= 'easeElastic'
                             needleColor='black'
                             segments= {3}
                             segmentColors ={['yellow','green','green','red']}
                             customSegmentStops = {[0,20,50,80,90]}
                             currentValueText = {'100'}
                             minValue={0}
                             maxValue ={90} 
                             value = {75}
                             textColor ={'black'}
                             width= {200}
                             height = {125}
                             />
                            <span style = {{backgroundColor: `green`, width: '82px', borderRadius: '7px',textAlign: 'center', color: `white`}}>Moderate</span>
                        </span>
                        <span style ={{fontSize: '20px', fontWeight: 'bolder', display:'block', textAlign: 'center', marginBottom: '20px'}}> Humidty  75%</span>
                        <span style ={{fontSize: '20px', fontWeight: 'bolder'}}>Low  {20}%</span>
                        <span style ={{marginLeft: '150px',fontSize: '20px', fontWeight: 'bolder'}}>High {90}%</span>
                    </Card.Body>

            </Card>
               </Col>
               <Col>
               <Card style = {{maxWidth: '370px', marginLeft: '100px', marginRight: '50px'}}>
                <Card.Header style ={{ fontSize: '20px', fontWeight: 'bold'}}>Corridor Temperature</Card.Header>
                    <Card.Body>
                        <span style = {{display:'flex', height: '170px', flexDirection: 'column', alignItems: 'center', gap: '10px'}}>
                           <ReactSpeedometer 
                             needleTransitionDuration={4000}
                             //@ts-ignore
                             needleTransition= 'easeElastic'
                             needleColor='black'
                             segments= {3}
                             segmentColors ={['yellow','green','green','red']}
                             customSegmentStops ={[18,25,30, 40, 50]}
                             currentValueText = {'18'}
                             minValue={18}
                             maxValue ={50}
                             value = {18}
                             textColor ={'black'}
                             width= {200}
                             height = {125}
                             />
                            <span style = {{backgroundColor: `yellow`, width: '82px', borderRadius: '7px',textAlign: 'center', color: `black`}}>Low</span>
                        </span>
                        <span style ={{fontSize: '20px', fontWeight: 'bolder', display:'block', textAlign: 'center', marginBottom: '20px'}}>Temperature {18}&deg;c</span>
                        <span style ={{fontSize: '20px', fontWeight: 'bolder'}}>Low  {20}&deg;c</span>
                        <span style ={{marginLeft: '150px',fontSize: '20px', fontWeight: 'bolder'}}>High {50}&deg;c</span>
                    </Card.Body>

            </Card>
               </Col>
               <Col>
               <Card style = {{maxWidth: '370px', marginLeft: '100px', marginRight: '50px'}}>
                <Card.Header style ={{ fontSize: '20px', fontWeight: 'bold'}}>Differential Pressure</Card.Header>
                    <Card.Body>
                        <span style = {{display:'flex', height: '170px', flexDirection: 'column', alignItems: 'center', gap: '10px'}}>
                           <ReactSpeedometer 
                             needleTransitionDuration={4000}
                             //@ts-ignore
                             needleTransition= 'easeElastic'
                             needleColor='black'
                             segments= {3}
                             segmentColors ={['yellow','green','green','red']}
                             customSegmentStops ={[50,70,101, 120,150]}
                             currentValueText = {`105`}
                             minValue={50}
                             maxValue ={150}
                             value = {105}
                             textColor ={'black'}
                             width= {200}
                             height = {125}
                             />
                            <span style = {{backgroundColor: `green`, width: '82px', borderRadius: '7px',textAlign: 'center', color: 'white'}}>Moderate</span>
                        </span>
                        <span style ={{fontSize: '20px', fontWeight: 'bolder', display:'block', textAlign: 'center', marginBottom: '20px'}}>Pressure {105} kPa</span>
                        <span style ={{fontSize: '20px', fontWeight: 'bolder'}}>Low  {50} kPa</span>
                        <span style ={{marginLeft: '150px',fontSize: '20px', fontWeight: 'bolder'}}>High {80} kPa</span>
                    </Card.Body>

            </Card>
               </Col>
            </Row>

          </Card>
        </Container>
        </div>
    )
  
}

export default TempratureDashboard;